package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/*
 * 【開発環境の準備】
 * 1. JDK：Javaをコンパイル・実行するための道具。
 *    java -version / javac -version で確認する。
 *
 * 2. Maven：ライブラリの取得や、コンパイル・WAR作成を行う道具。
 *    ~/tools に配置し、binをPATHに追加してmvnで呼び出せるようにした。
 *
 * 3. Tomcat：サーブレットとJSPを実行するサーバー。
 *    ~/tools に配置した。
 *
 * 【プロジェクト内の役割】
 * ・pom.xml
 *   Mavenに、必要なライブラリとビルド方法を伝える設定ファイル。
 *
 * ・src/main/java
 *   サーブレットなど、Javaのソースコードを置く場所。
 *
 * ・src/main/webapp
 *   HTML・CSS・JSPなど、Web用のファイルを置く場所。
 *
 * ・WEB-INF
 *   ブラウザから直接アクセスできない場所。
 *   今回はJSPを置き、サーブレットからforwardで呼び出す。
 *
 * ・target
 *   Mavenが生成した.classやWARなどのビルド結果を置く場所。
 *   修正するのはsrc側。target内はビルドで作り直される。
 *
 * 【ビルドから実行まで】
 * 1. Java・JSPを編集して保存する。
 *
 * 2. プロジェクト直下で mvn clean package を実行する。
 *    clean   ：前回のビルド結果を削除する。
 *    package ：コンパイルし、今回はWARにまとめる。
 *    結果    ：target/servlet-practice.war ができる。
 *
 * 3. Tomcatを停止した状態で、WARをTomcatのwebappsにコピーする。
 *    このように、アプリを実行環境に配置することを「デプロイ」と呼ぶ。
 *
 * 4. Tomcatのbin内で bash catalina.sh run を実行する。
 *    起動中はターミナルを開いたままにする。停止はControl＋C。
 *
 * 5. ブラウザで以下にアクセスする。
 *    http://localhost:8080/servlet-practice/hello
 *
 * 【アクセスしたときの処理】
 * 1. ブラウザがTomcatへHTTPリクエストを送る。
 * 2. Tomcatが、アプリ内の /hello に対応するサーブレットを呼ぶ。
 * 3. GETリクエストなので、doGet()が実行される。
 * 4. setAttribute()で、リクエストにmessageという名前でデータを入れる。
 * 5. forward()で、同じリクエストをJSPに渡す。
 * 6. JSPが ${message} を使い、メッセージ入りのHTMLを作る。
 * 7. TomcatがHTMLを返し、ブラウザが表示する。
 *
 * 【コードを修正した後】
 * 保存 → 再ビルド → Tomcat停止 → WARを再コピー
 * → Tomcat起動 → ブラウザで再読み込み。
 *
 * Mavenはアプリを「作る道具」。
 * Tomcatは作ったアプリを「動かす道具」。
 */


@WebServlet("/hello")
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("message", "サーブレットから届いたメッセージです！");

        request.getRequestDispatcher("/WEB-INF/jsp/hello.jsp")
               .forward(request, response);
    }
}