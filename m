Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A02C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FB424350
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172337;
	bh=5FARUNYaWzkzpRMVpWdAMLOEnkwhlpPbfTXFwVo2KQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iC6hD727fT1ENJ5SYQ3DfunvzAnaIRbCLSc6WOn87a+X50zxHIW51fV/+0CekmIMx
	 aR7TjPRNROoj2rRUvE9vlNAIi0pWZPkDEwMWfpbDWEeX8gxApZHlunBLJLpefQx8x5
	 zAx/FzxvWnjmCSkHMmi0MajpSSIju34kwW4tZsjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfE2XZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:25:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfE2XYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/TdADaT8F3LqA+lmP7ZjH43HVzdnE74k/mrpxzfWfYg=; b=d8q+NraMyuHpWbJK2lQs8LIrkG
        Yy3/vRZSon1znZfBVIO0L9Ho9GtmZPJjE6WHGDvwjAs+rD2jSkeiLaLNUaH9LGIhmEIEhr3+mADCO
        mmG3/iTS+7lHHw5XJoaXaK8srmlApv03vnSzaNfigY5B6fO9n97dUgmbtrBq8HrkC52OnfBsnDwk3
        x4c+xMr+ZgKDJa5tbtSHc+YVZhs8//X5qQkdZvRE9GOQ9KPcWCit7Z6r+XBvc+zJVjmDFcn3CDRXs
        jbDPEBVuWsFNYZeIMKkvLTxUNz7imbdYjG1K1NpGakX9i13qGwg+ng3NCyitBuNGdTfVfpjnhDMwo
        lvp3On7w==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rc-0s; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007wx-JD; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH 04/22] docs: zh_CN: get rid of basic_profiling.txt
Date:   Wed, 29 May 2019 20:23:35 -0300
Message-Id: <81f5848d02cafb986d9145dbff17beb1e4427dea.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 5700d1974818 ("docs: Get rid of the "basic profiling" guide")
removed an old basic-profiling.txt file that was not updated over
the last 11 years and won't reflect the post-perf era.

It makes no sense to keep its translation, so get rid of it too.

Fixes: 5700d1974818 ("docs: Get rid of the "basic profiling" guide")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../translations/zh_CN/basic_profiling.txt    | 71 -------------------
 1 file changed, 71 deletions(-)
 delete mode 100644 Documentation/translations/zh_CN/basic_profiling.txt

diff --git a/Documentation/translations/zh_CN/basic_profiling.txt b/Documentation/translations/zh_CN/basic_profiling.txt
deleted file mode 100644
index 1e6bf0bdf8f5..000000000000
--- a/Documentation/translations/zh_CN/basic_profiling.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-Chinese translated version of Documentation/basic_profiling
-
-If you have any comment or update to the content, please post to LKML directly.
-However, if you have problem communicating in English you can also ask the
-Chinese maintainer for help.  Contact the Chinese maintainer, if this
-translation is outdated or there is problem with translation.
-
-Chinese maintainer: Liang Xie <xieliang@xiaomi.com>
----------------------------------------------------------------------
-Documentation/basic_profiling的中文翻译
-
-如果想评论或更新本文的内容，请直接发信到LKML。如果你使用英文交流有困难的话，也可
-以向中文版维护者求助。如果本翻译更新不及时或者翻译存在问题，请联系中文版维护者。
-
-中文版维护者： 谢良 Liang Xie <xieliang007@gmail.com>
-中文版翻译者： 谢良 Liang Xie <xieliang007@gmail.com>
-中文版校译者：
-以下为正文
----------------------------------------------------------------------
-
-下面这些说明指令都是非常基础的，如果你想进一步了解请阅读相关专业文档：）
-请不要再在本文档增加新的内容，但可以修复文档中的错误：）(mbligh@aracnet.com)
-感谢John Levon，Dave Hansen等在撰写时的帮助
-
-<test> 用于表示要测量的目标
-请先确保您已经有正确的System.map / vmlinux配置！
-
-对于linux系统来说，配置vmlinuz最容易的方法可能就是使用“make install”，然后修改
-/sbin/installkernel将vmlinux拷贝到/boot目录，而System.map通常是默认安装好的
-
-Readprofile
------------
-2.6系列内核需要版本相对较新的readprofile，比如util-linux 2.12a中包含的，可以从:
-
-http://www.kernel.org/pub/linux/utils/util-linux/ 下载
-
-大部分linux发行版已经包含了.
-
-启用readprofile需要在kernel启动命令行增加”profile=2“
-
-clear		readprofile -r
-		<test>
-dump output	readprofile -m /boot/System.map > captured_profile
-
-Oprofile
---------
-
-从http://oprofile.sourceforge.net/获取源代码（请参考Changes以获取匹配的版本）
-在kernel启动命令行增加“idle=poll”
-
-配置CONFIG_PROFILING=y和CONFIG_OPROFILE=y然后重启进入新kernel
-
-./configure --with-kernel-support
-make install
-
-想得到好的测量结果，请确保启用了本地APIC特性。如果opreport显示有0Hz CPU，
-说明APIC特性没有开启。另外注意idle=poll选项可能有损性能。
-
-One time setup:
-		opcontrol --setup --vmlinux=/boot/vmlinux
-
-clear		opcontrol --reset
-start		opcontrol --start
-		<test>
-stop		opcontrol --stop
-dump output	opreport >  output_file
-
-如果只看kernel相关的报告结果，请运行命令 opreport -l /boot/vmlinux > output_file
-
-通过reset选项可以清理过期统计数据，相当于重启的效果。
-
-- 
2.21.0

