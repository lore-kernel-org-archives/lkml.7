Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC9EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2364206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfC0NCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:02:42 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36380 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730241AbfC0NCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TNmt4b3_1553691750;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmt4b3_1553691750)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:30 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        SeongJae Park <sj38.park@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 34/42] docs/zh_CN: update howto.rst to latest version
Date:   Wed, 27 Mar 2019 21:01:40 +0800
Message-Id: <20190327130148.3258-35-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
References: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removed the obsolete 2.6.x examples, sub-system tree
and updated some links/items following latest Englisht version howto

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../translations/zh_CN/process/howto.rst      | 154 ++++++------------
 1 file changed, 49 insertions(+), 105 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 246f76a97eaf..cb41336ccb80 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -63,9 +63,11 @@ Linux内核使用GNU C和GNU工具链开发。虽然它遵循ISO C89标准，但
 --------
 
 Linux内核源代码都是在GPL（通用公共许可证）的保护下发布的。要了解这种许可
-的细节请查看源代码主目录下的COPYING文件。如果你对它还有更深入问题请联系
-律师，而不要在Linux内核邮件组上提问。因为邮件组里的人并不是律师，不要期
-望他们的话有法律效力。
+的细节请查看源代码主目录下的COPYING文件。Linux内核许可准则和如果使用
+`SPDC <https://spdx.org/>` 标志符说明在文件
+:ref:`Documentation/process/license-rules.rst <kernel_licensing>`
+如果你对它还有更深入问题请联系律师，而不要在Linux内核邮件组上提问。因为
+邮件组里的人并不是律师，不要期望他们的话有法律效力。
 
 对于GPL的常见问题和解答，请访问以下链接：
 	http://www.gnu.org/licenses/gpl-faq.html
@@ -177,19 +179,13 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 集成进内核的基本原理。如果还没有决定下一步要做什么的话，你还可能会得到方
 向性的指点。
 
-如果你已经有一些现成的代码想要放到内核中，但是需要一些帮助来使它们拥有正
-确的格式。请访问“内核导师”计划。这个计划就是用来帮助你完成这个目标的。它
-是一个邮件列表，地址如下：
-
-	http://selenic.com/mailman/listinfo/kernel-mentors
-
 在真正动手修改内核代码之前，理解要修改的代码如何运作是必需的。要达到这个
 目的，没什么办法比直接读代码更有效了（大多数花招都会有相应的注释），而且
 一些特制的工具还可以提供帮助。例如，“Linux代码交叉引用”项目就是一个值得
 特别推荐的帮助工具，它将源代码显示在有编目和索引的网页上。其中一个更新及
 时的内核源码库，可以通过以下地址访问：
 
-	http://sosdg.org/~coywolf/lxr/
+        https://elixir.bootlin.com/
 
 
 开发流程
@@ -198,17 +194,16 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 目前Linux内核开发流程包括几个“主内核分支”和很多子系统相关的内核分支。这
 些分支包括：
 
-  - 2.6.x主内核源码树
-  - 2.6.x.y -stable内核源码树
-  - 2.6.x -mm内核补丁集
-  - 子系统相关的内核源码树和补丁集
+  - Linus 的内核源码树
+  - 多个主要版本的稳定版内核树
+  - 子系统相关的内核树
+  - linux-next 集成测试树
 
 
-2.6.x内核主源码树
------------------
-2.6.x内核是由Linus Torvalds（Linux的创造者）亲自维护的。你可以在
-kernel.org网站的pub/linux/kernel/v2.6/目录下找到它。它的开发遵循以下步
-骤：
+主线树
+------
+主线树是由Linus Torvalds 维护的。你可以在https://kernel.org 网站或者代码
+库中下找到它。它的开发遵循以下步骤：
 
   - 每当一个新版本的内核被发布，为期两周的集成窗口将被打开。在这段时间里
     维护者可以向Linus提交大段的修改，通常这些修改已经被放到-mm内核中几个
@@ -229,96 +224,49 @@ kernel.org网站的pub/linux/kernel/v2.6/目录下找到它。它的开发遵循
 	“没有人知道新内核何时会被发布，因为发布是根据已知bug的情况来决定
 	的，而不是根据一个事先制定好的时间表。”
 
+子系统特定树
+------------
 
-2.6.x.y -stable（稳定版）内核源码树
------------------------------------
-由4个数字组成的内核版本号说明此内核是-stable版本。它们包含基于2.6.x版本
-内核的相对较小且至关重要的修补，这些修补针对安全性问题或者严重的内核退步。
-
-这种版本的内核适用于那些期望获得最新的稳定版内核并且不想参与测试开发版或
-者实验版的用户。
-
-如果没有2.6.x.y版本内核存在，那么最新的2.6.x版本内核就相当于是当前的稳定
-版内核。
-
-2.6.x.y版本由“稳定版”小组（邮件地址<stable@vger.kernel.org>）维护，一般隔周发
-布新版本。
-
-内核源码中的 :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
-文件具体描述了可被稳定版内核接受的修改类型以及发布的流程。
-
-
-2.6.x -mm补丁集
----------------
-这是由Andrew Morton维护的试验性内核补丁集。Andrew将所有子系统的内核源码
-和补丁拼凑到一起，并且加入了大量从linux-kernel邮件列表中采集的补丁。这个
-源码树是新功能和补丁的试炼场。当补丁在-mm补丁集里证明了其价值以后Andrew
-或者相应子系统的维护者会将补丁发给Linus以便集成进主内核源码树。
-
-在将所有新补丁发给Linus以集成到主内核源码树之前，我们非常鼓励先把这些补
-丁放在-mm版内核源码树中进行测试。
+各种内核子系统的维护者——以及许多内核子系统开发人员——在源代码库中公开了他们
+当前的开发状态。这样，其他人就可以看到内核的不同区域发生了什么。在开发速度
+很快的领域，可能会要求开发人员将提交的内容建立在这样的子系统内核树上，这样
+就避免了提交与其他已经进行的工作之间的冲突。
 
-这些内核版本不适合在需要稳定运行的系统上运行，因为运行它们比运行任何其他
-内核分支都更具有风险。
+这些存储库中的大多数都是Git树，但是也有其他的scm在使用，或者补丁队列被发布
+为Quilt系列。这些子系统存储库的地址列在MAINTAINERS文件中。其中许多可以在
+https://git.kernel.org/上浏览。
 
-如果你想为内核开发进程提供帮助，请尝试并使用这些内核版本，并在
-linux-kernel邮件列表中提供反馈，告诉大家你遇到了问题还是一切正常。
+在将一个建议的补丁提交到这样的子系统树之前，需要对它进行审查，审查主要发生
+在邮件列表上（请参见下面相应的部分）。对于几个内核子系统，这个审查过程是通
+过工具补丁跟踪的。Patchwork提供了一个Web界面，显示补丁发布、对补丁的任何评
+论或修订，维护人员可以将补丁标记为正在审查、接受或拒绝。大多数补丁网站都列
+在 https://patchwork.kernel.org/
 
-通常-mm版补丁集不光包括这些额外的试验性补丁，还包括发布时-git版主源码树
-中的改动。
+Linux-next 集成测试树
+---------------------
 
--mm版内核没有固定的发布周期，但是通常在每两个-rc版内核发布之间都会有若干
-个-mm版内核发布（一般是1至3个）。
+在将子系统树的更新合并到主线树之前，需要对它们进行集成测试。为此，存在一个
+特殊的测试存储库，其中几乎每天都会提取所有子系统树：
 
+        https://git.kernel.org/？p=linux/kernel/git/next/linux-next.git
 
-子系统相关内核源码树和补丁集
-----------------------------
-相当一部分内核子系统开发者会公开他们自己的开发源码树，以便其他人能了解内
-核的不同领域正在发生的事情。如上所述，这些源码树会被集成到-mm版本内核中。
+通过这种方式，Linux-next 对下一个合并阶段将进入主线内核的内容给出了一个概要
+展望。非常欢冒险的测试者运行测试Linux-next。
 
-下面是目前可用的一些内核源码树的列表：
-  通过git管理的源码树：
-    - Kbuild开发源码树， Sam Ravnborg <sam@ravnborg.org>
-	git.kernel.org:/pub/scm/linux/kernel/git/sam/kbuild.git
-
-    - ACPI开发源码树, Len Brown <len.brown@intel.com>
-	git.kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
-
-    - 块设备开发源码树, Jens Axboe <axboe@suse.de>
-	git.kernel.org:/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
-
-    - DRM开发源码树, Dave Airlie <airlied@linux.ie>
-	git.kernel.org:/pub/scm/linux/kernel/git/airlied/drm-2.6.git
-
-    - ia64开发源码树, Tony Luck <tony.luck@intel.com>
-	git.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
-
-    - ieee1394开发源码树, Jody McIntyre <scjody@modernduck.com>
-	git.kernel.org:/pub/scm/linux/kernel/git/scjody/ieee1394.git
-
-    - infiniband开发源码树, Roland Dreier <rolandd@cisco.com>
-	git.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git
-
-    - libata开发源码树, Jeff Garzik <jgarzik@pobox.com>
-	git.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
-
-    - 网络驱动程序开发源码树, Jeff Garzik <jgarzik@pobox.com>
-	git.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
+多个主要版本的稳定版内核树
+-----------------------------------
+由3个数字组成的内核版本号说明此内核是-stable版本。它们包含内核的相对较小且
+至关重要的修补，这些修补针对安全性问题或者严重的内核退步。
 
-    - pcmcia开发源码树, Dominik Brodowski <linux@dominikbrodowski.net>
-	git.kernel.org:/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git
+这种版本的内核适用于那些期望获得最新的稳定版内核并且不想参与测试开发版或
+者实验版的用户。
 
-    - SCSI开发源码树, James Bottomley <James.Bottomley@SteelEye.com>
-	git.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
+稳定版内核树版本由“稳定版”小组（邮件地址<stable@vger.kernel.org>）维护，一般
+隔周发布新版本。
 
-  使用quilt管理的补丁集：
-    - USB, PCI, 驱动程序核心和I2C, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-	kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
-    - x86-64, 部分i386, Andi Kleen <ak@suse.de>
-	ftp.firstfloor.org:/pub/ak/x86_64/quilt/
+内核源码中的 :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
+文件具体描述了可被稳定版内核接受的修改类型以及发布的流程。
 
-  其他内核源码树可以在 http://git.kernel.org 的列表中和MAINTAINERS文件里
-  找到。
 
 报告bug
 -------
@@ -328,8 +276,9 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
 
 	http://test.kernel.org/bugzilla/faq.html
 
-内核源码主目录中的admin-guide/reporting-bugs.rst文件里有一个很好的模板。它指导用户如何报
-告可能的内核bug以及需要提供哪些信息来帮助内核开发者们找到问题的根源。
+内核源码主目录中的:ref:`admin-guide/reporting-bugs.rst <reportingbugs>`
+文件里有一个很好的模板。它指导用户如何报告可能的内核bug以及需要提供哪些信息
+来帮助内核开发者们找到问题的根源。
 
 
 利用bug报告
@@ -340,12 +289,7 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
 者感受到你的存在。修改bug是赢得其他开发者赞誉的最好办法，因为并不是很多
 人都喜欢浪费时间去修改别人报告的bug。
 
-要尝试修改已知的bug，请访问 http://bugzilla.kernel.org 网址。如果你想获得
-最新bug的通知，可以订阅bugme-new邮件列表（只有新的bug报告会被寄到这里）
-或者订阅bugme-janitor邮件列表（所有bugzilla的变动都会被寄到这里）。
-
-	https://lists.linux-foundation.org/mailman/listinfo/bugme-new
-	https://lists.linux-foundation.org/mailman/listinfo/bugme-janitors
+要尝试修改已知的bug，请访问 http://bugzilla.kernel.org 网址。
 
 
 邮件列表
-- 
2.19.1.856.g8858448bb

