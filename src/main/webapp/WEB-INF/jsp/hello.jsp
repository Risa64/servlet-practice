<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>サーブレット・JSP 学習メモ</title>

    <style>
        body {
            font-family: sans-serif;
            line-height: 1.8;
            max-width: 900px;
            margin: 0 auto;
            padding: 24px;
            color: #263238;
            background-color: #f5f7fa;
        }

        section {
            background-color: white;
            padding: 20px;
            margin-bottom: 24px;
            border-radius: 8px;
        }

        h1, h2 {
            color: #1565c0;
        }

        code {
            background-color: #e8eef5;
            padding: 2px 6px;
            border-radius: 4px;
            overflow-wrap: anywhere;
        }

        li {
            margin-bottom: 12px;
        }
    </style>
</head>
<body>
    <h1>サーブレット・JSP 学習メモ</h1>
    <p>${message}</p>

    <section>
        <h2>1. 開発に使う道具</h2>
        <ul>
            <li><strong>JDK：</strong>
                Javaをコンパイル・実行するための道具。</li>
            <li><strong>Maven：</strong>
                ライブラリを取得し、コンパイルやWAR作成を行う道具。</li>
            <li><strong>Tomcat：</strong>
                サーブレットとJSPを実行するサーバー。</li>
            <li><strong>VS Code：</strong>
                コードを編集するためのエディター。</li>
        </ul>
    </section>

    <section>
        <h2>2. ファイルとフォルダの役割</h2>
        <ul>
            <li><code>pom.xml</code>：
                必要なライブラリとビルド方法をMavenに伝える。</li>
            <li><code>src/main/java</code>：
                サーブレットなどのJavaコードを置く。</li>
            <li><code>src/main/webapp</code>：
                HTML・CSS・JSPなどのWeb用ファイルを置く。</li>
            <li><code>WEB-INF</code>：
                ブラウザから直接アクセスできない場所。
                今回はJSPを置き、サーブレットから呼び出す。</li>
            <li><code>target</code>：
                Mavenが生成した.classやWARなどを置く。
                コードの修正はsrc側で行う。</li>
            <li><strong>Tomcatの<code>webapps</code>：</strong>
                実行するWebアプリを配置する場所。</li>
        </ul>
    </section>

    <section>
        <h2>3. コードを書いてから実行するまで</h2>
        <ol>
            <li>Java・JSPを編集して保存する。</li>
            <li>
                プロジェクト直下で
                <code>mvn clean package</code>を実行する。
                <ul>
                    <li><code>clean</code>：前回のビルド結果を削除する。</li>
                    <li><code>package</code>：
                        コンパイルし、今回はWARにまとめる。</li>
                </ul>
            </li>
            <li>
                Tomcatを停止した状態で、
                <code>target/servlet-practice.war</code>を
                Tomcatの<code>webapps</code>にコピーする。
                この配置作業を「デプロイ」と呼ぶ。
            </li>
            <li>
                Tomcatの<code>bin</code>内で
                <code>bash catalina.sh run</code>を実行する。
                停止するときは、ターミナルでControl＋Cを押す。
            </li>
            <li>
                ブラウザで
                <code>http://localhost:8080/servlet-practice/hello</code>
                にアクセスする。
            </li>
        </ol>
    </section>

    <section>
        <h2>4. ブラウザからアクセスしたときの処理</h2>
        <ol>
            <li>ブラウザがTomcatへHTTPリクエストを送る。</li>
            <li>
                Tomcatがアプリ内の
                <code>@WebServlet("/hello")</code>
                に対応するサーブレットを呼ぶ。
            </li>
            <li>GETリクエストなので、<code>doGet()</code>が実行される。</li>
            <li>
                <code>setAttribute()</code>で、
                リクエストにmessageという名前でデータを入れる。
            </li>
            <li><code>forward()</code>で、同じリクエストをJSPに渡す。</li>
            <li>
                JSPが、受け取ったmessageの値を埋め込んでHTMLを作る。
            </li>
            <li>TomcatがHTMLを返し、ブラウザが表示する。</li>
        </ol>
    </section>

    <section>
        <h2>5. コードを修正した後の手順</h2>
        <p>
            保存 → 再ビルド → Tomcat停止 → WARを再コピー
            → Tomcat起動 → ブラウザで再読み込み
        </p>
        <p>
            <strong>Mavenはアプリを「作る道具」。</strong><br>
            <strong>Tomcatはアプリを「動かす道具」。</strong>
        </p>
    </section>
</body>
</html>