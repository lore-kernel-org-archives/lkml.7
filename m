Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A323C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5012084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfCLD0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:26:00 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48242 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbfCLDZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:25:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMWLxjS_1552361145;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWLxjS_1552361145)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:25:46 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Yang <leoyang.li@nxp.com>, TripleX Chung <xxx.phy@gmail.com>
Subject: [PATCH v4 27/31] docs/zh_CN: fix indent issue in stable-api-nonsense file
Date:   Tue, 12 Mar 2019 11:24:56 +0800
Message-Id: <20190312032501.62056-28-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
References: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tame the 'make htmldocs' to avoid 'ERROR: Unexpected indentation'
etc errors.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: TripleX Chung <xxx.phy@gmail.com>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .../zh_CN/process/stable-api-nonsense.rst     | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/stable-api-nonsense.rst b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
index 42d974e6dc35..beb94200b35e 100644
--- a/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
+++ b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
@@ -54,18 +54,22 @@ Linux能成为强壮，稳定，成熟的操作系统，这也是你最开始选
 --------------
 假如我们有一个稳定的内核源代码接口，那么自然而然的，我们就拥有了稳定的
 二进制接口，是这样的吗？错。让我们看看关于Linux内核的几点事实：
+
     - 取决于所用的C编译器的版本，不同的内核数据结构里的结构体的对齐方
-式会有差别，代码中不同函数的表现形式也不一样（函数是不是被inline编译取
-决于编译器行为）。不同的函数的表现形式并不重要，但是数据结构内部的对齐
-方式很关键。
+      式会有差别，代码中不同函数的表现形式也不一样（函数是不是被inline
+      编译取决于编译器行为）。不同的函数的表现形式并不重要，但是数据
+      结构内部的对齐方式很关键。
+
     - 取决于内核的配置选项，不同的选项会让内核的很多东西发生改变：
+
       - 同一个结构体可能包含不同的成员变量
       - 有的函数可能根本不会被实现（比如编译的时候没有选择SMP支持
-，一些锁函数就会被定义成空函数）。
+        一些锁函数就会被定义成空函数）。
       - 内核使用的内存会以不同的方式对齐，这取决于不同的内核配置选
-项。
+        项。
+
     - Linux可以在很多的不同体系结构的处理器上运行。在某个体系结构上编
-译好的二进制驱动程序，不可能在另外一个体系结构上正确的运行。
+      译好的二进制驱动程序，不可能在另外一个体系结构上正确的运行。
 
 对于一个特定的内核，满足这些条件并不难，使用同一个C编译器和同样的内核配
 置选项来编译驱动程序模块就可以了。这对于给一个特定Linux发布的特定版本提
@@ -85,7 +89,7 @@ Linux能成为强壮，稳定，成熟的操作系统，这也是你最开始选
 
 如果有人不将他的内核驱动程序，放入公版内核的源代码树，而又想让驱动程序
 一直保持在最新的内核中可用，那么这个话题将会变得没完没了。
- 内核开发是持续而且快节奏的，从来都不会慢下来。内核开发人员在当前接口中
+内核开发是持续而且快节奏的，从来都不会慢下来。内核开发人员在当前接口中
 找到bug，或者找到更好的实现方式。一旦发现这些，他们就很快会去修改当前的
 接口。修改接口意味着，函数名可能会改变，结构体可能被扩充或者删减，函数
 的参数也可能发生改变。一旦接口被修改，内核中使用这些接口的地方需要同时
@@ -93,21 +97,22 @@ Linux能成为强壮，稳定，成熟的操作系统，这也是你最开始选
 
 举一个例子，内核的USB驱动程序接口在USB子系统的整个生命周期中，至少经历
 了三次重写。这些重写解决以下问题：
+
     - 把数据流从同步模式改成非同步模式，这个改动减少了一些驱动程序的
-复杂度，提高了所有USB驱动程序的吞吐率，这样几乎所有的USB设备都能以最大
-速率工作了。
+      复杂度，提高了所有USB驱动程序的吞吐率，这样几乎所有的USB设备都
+      能以最大速率工作了。
     - 修改了USB核心代码中为USB驱动分配数据包内存的方式，所有的驱动都
-需要提供更多的参数给USB核心，以修正了很多已经被记录在案的死锁。
+      需要提供更多的参数给USB核心，以修正了很多已经被记录在案的死锁。
 
 这和一些封闭源代码的操作系统形成鲜明的对比，在那些操作系统上，不得不额
 外的维护旧的USB接口。这导致了一个可能性，新的开发者依然会不小心使用旧的
 接口，以不恰当的方式编写代码，进而影响到操作系统的稳定性。
- 在上面的例子中，所有的开发者都同意这些重要的改动，在这样的情况下修改代
+在上面的例子中，所有的开发者都同意这些重要的改动，在这样的情况下修改代
 价很低。如果Linux保持一个稳定的内核源代码接口，那么就得创建一个新的接口
 ；旧的，有问题的接口必须一直维护，给Linux USB开发者带来额外的工作。既然
 所有的Linux USB驱动的作者都是利用自己的时间工作，那么要求他们去做毫无意
 义的免费额外工作，是不可能的。
- 安全问题对Linux来说十分重要。一个安全问题被发现，就会在短时间内得到修
+安全问题对Linux来说十分重要。一个安全问题被发现，就会在短时间内得到修
 正。在很多情况下，这将导致Linux内核中的一些接口被重写，以从根本上避免安
 全问题。一旦接口被重写，所有使用这些接口的驱动程序，必须同时得到修正，
 以确定安全问题已经得到修复并且不可能在未来还有同样的安全问题。如果内核
@@ -132,14 +137,14 @@ Linux能成为强壮，稳定，成熟的操作系统，这也是你最开始选
 做什么事情。
 
 把驱动放到内核源代码树里会有很多的好处：
+
     - 驱动的质量会提升，而维护成本（对原始作者来说）会下降。
     - 其他人会给驱动添加新特性。
     - 其他人会找到驱动中的bug并修复。
     - 其他人会在驱动中找到性能优化的机会。
     - 当外部的接口的改变需要修改驱动程序的时候，其他人会修改驱动程序
-。
     - 不需要联系任何发行商，这个驱动会自动的随着所有的Linux发布一起发
-布。
+      布。
 
 和别的操作系统相比，Linux为更多不同的设备提供现成的驱动，而且能在更多不
 同体系结构的处理器上支持这些设备。这个经过考验的开发模式，必然是错不了
-- 
2.19.1.856.g8858448bb

