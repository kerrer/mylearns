主流开源ESB产品
 

2009-08-18 来源：网络
 

在开源ESB家族中涌现出很多优秀的开源ESB，比如，Mule，Apache ServiceMix,Open [url][/url]ESB,Apache Synapse等。为了大家更好地了解它们，我作了简要地介绍。

Mule

它是一个轻量级的消息框架和整合平台，基于EIP（Enterprise Integeration Patterns,由Hohpe和Woolf编写的一本书）而实现的。

Mule的核心组件是UMO(Universal Message Objects，从Mule2.0开始UMO这一概念已经被组件Componse所代替)，UMO实现整合逻辑。

UMO可以是POJO,JavaBean等等。

它支持20多种传输协议(file,FTP,UDP,SMTP,POP,HTTP,SOAP,JMS等)，并整合了许多流行的开源项目，比如Spring,ActiveMQ,CXF,
Axis,Drools等。虽然Mule没有基于JBI来构建其架构，但是它为JBI容器提供了JBI适配器，应此可以很好地与JBI容器整合在一起。而 Mule更关注其灵活性，高效性以及易开发性。从2005年发表1.0版本以来，Mule吸引了越来越多的关注者，成为开源ESB中的一支独秀。目前许多公司都使用了Mule，比如Walmart,HP,Sony,Deutsche Bank 以及 CitiBank等公司。

官方网站：http://mule.codehaus.org/

Apache ServiceMix

它是JBI规范的一种实现。它包涵了许多JBI组件，这些组件支持多种协议，比如JMS,HTTP,FTP,FILE等。同时也实现了EIP，规则和调度。自从JBI被JCP接收后，2005年末Apache ServiceMix才被Apache作为其卵化项目，到2007年9月，它已经成为Apache的顶级项目。ApacheServiceMix 也整合了其他的开源项目，比如Apache ActiveMQ,Apache CXF,Apahe Camel,Apache ODE以及Apache Geronimo。

说起Apache ServiceMix,就会使我想到LogicBlaze公司。它曾经是Apache ServiceMix和Apache ActiveMQ的商业支持者。2006年LogicBlaze被IONA成功收购后，IONA负责为Apache ServiceMix提供支持和服务。同时IONA也将Apache ServiceMix作为FUSE平台中的一员，FUSE旗下还包括Apache ActiveMQ,Apache CXF,Apahe Camel,FUSE HQ。

官方网站：http://servicemix.apache.org/

Fuse平台的官方网站：http://open.iona.com/products/fuse-esb/

Open ESB

前两个开源ESB都由开源社区提供支持，Mule由Codehaus社区提供支持，ServiceMix由Apache社区提供支持。Open ESB是由SUN发起，现在作为Java.net的子项目。所有Open ESB的开发人员都来自SUN。

如同Apache ServiceMix一样，Open ESB也实现了JBI规范。Open ESB可运行在由SUN支持的Glassfish应用服务中。同时SUN的Netbeans IDE为Open ESB提供了拖拉式的开发工具，这是其他开源ESB不可匹敌的，尽管Mule也提供了基于Eclipse的插件工具，但目前仍然不够强大。

官方网站：https://open-esb.dev.java.net/

Apache Synapse

虽然Apache Synapse具备一些ESB所必备的功能，但是从本质上而言Synapse更是一个web服务仲裁框架，它是构建在Apache Axis2之上的。Synapse的关注点是路由，转换，消息验证以及基于web服务和xml标准的注册。它支持HTTP, SOAP, SMTP, JMS,FTP ,MTOM/XOPPOP3/IMAP/SMTP 等传输协议，还支持多种web服务规范(WS-*)，比如WS-Addressing,WS-Security,WS-Policy以及WS- Reliable Messaging。在它的最新版本1.2中加入了对FIX(Financial Information eXchange,金融信息交换协议 ) 和 Hessian  的支持。同时它还支持多种流行语言，比如Java, JavaScript, Ruby, Groovy等。

官方网站：http://ws.apache.org/synapse

JBoss ESB

JBoss ESB是基于JBoss公司的ESB产品Rosetta的。Jboss ESB将JbossMQ作为其消息层，将JBoss rules为其提供路由功能， 将jBPM为其提供服务编排功能。足以见得JBoss的野心。

官方网站：http://labs.jboss.com/jbossesb/

其他的开源ESB

WSO2是基于Apache Synapse产品的，通过它可以在web服务，REST/POX服务以及遗留系统间连接，管理和转换服务交互。它还提供了一个基于AJAX的ESB管理控制台对其配置文件进行统计分析，管理（添加，删除以及修改等），和指定执行相应的配置文件。这在开源ESB中是非常少见的。

官方网站：http://wso2.com/products/esb/

OpenAdaptor定位于EAI （Enterprise Application Integration，企业应用集成）软件。它支持各种传输协议，如JMS, JDBC, IBM MQ Series, TIBCO Rendezvous, TCP/IP Sockets, SOAP, HTTP 和 File等。其最新版本为openadaptor3，与先前版本相比，它完全重写了一边，保留了原有的功能，提升了其简单性。

官方网站：https://www.openadaptor.org/

点击 http://opensourceforce.org/?fromuid=217 在《整合层综合》版块中即可查看相关开源ESB的架构图。 
