Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE263C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962FC2430D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172249;
	bh=SWSss3PHjLrsT7VY6xZy0SRSu079wbSDAwzq4tf2azI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CmvQyaUd1NOxMTYuwzo+jX89lw0fSutNzecp8EccqKwjzVwmvXi2/yXF6PYip84QV
	 s2zI8Zdtj3gbJChTDQJENeJZOASZ8ky2Ho6NNYbbNUbyR3+lTmboYTxqjq/PjVObk1
	 NSi63F5Q2wGnlgvwY+uzvLzCGSsibYlukp/NSKYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfE2XYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:24:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49084 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfE2XYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vV/6SDE/E7zcgK8uc3lPPsLgLzmr7K6D9Lr4cA++5kk=; b=ZKiNc9vAH6atsmbeWicMMvUVDX
        0lPfX5z4PAxqzmwWfwZF3ecQWJEXtp+TQXxyDySdsL8PC6bQIl483oCp3qDUFGROXvHiU/bRg+tt7
        62PnTOE5u7qOFESgDfDZ/gTahD/v1bDIm21Dg3kCoUs2QeQWlHUi0hkCTvw+3fb2nSjn1KY6NizBA
        iHFjTI2UVEB3tCl3o9PxwPpinSEPpITr8iVxYWvJ47B4cpSIanoW65alIOvLZjxrrcOiLZixKakPl
        TmPdZmC94LyGFAjTmptp6CWjN3tyaQLMqlMlp/vhsn9/dNVc2ew4fgOSR2VRPzYm8hwoCepfgiGf6
        nH6ZAAjw==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rk-8x; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007xY-Qo; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH 13/22] docs: zh_CN: avoid duplicate citation references
Date:   Wed, 29 May 2019 20:23:44 -0300
Message-Id: <9d3b9729663f75249b514dd3910309eb418d9e46.1559171394.git.mchehab+samsung@kernel.org>
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

    Documentation/process/management-style.rst:35: WARNING: duplicate label decisions, other instance in     Documentation/translations/zh_CN/process/management-style.rst
    Documentation/process/programming-language.rst:37: WARNING: duplicate citation c-language, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:38: WARNING: duplicate citation gcc, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:39: WARNING: duplicate citation clang, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:40: WARNING: duplicate citation icc, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:41: WARNING: duplicate citation gcc-c-dialect-options, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:42: WARNING: duplicate citation gnu-extensions, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:43: WARNING: duplicate citation gcc-attribute-syntax, other instance in     Documentation/translations/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:44: WARNING: duplicate citation n2049, other instance in     Documentation/translations/zh_CN/process/programming-language.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../zh_CN/process/management-style.rst        |  4 +--
 .../zh_CN/process/programming-language.rst    | 28 +++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/management-style.rst b/Documentation/translations/zh_CN/process/management-style.rst
index a181fa56d19e..c6a5bb285797 100644
--- a/Documentation/translations/zh_CN/process/management-style.rst
+++ b/Documentation/translations/zh_CN/process/management-style.rst
@@ -28,7 +28,7 @@ Linux内核管理风格
 
 不管怎样，这里是：
 
-.. _decisions:
+.. _cn_decisions:
 
 1）决策
 -------
@@ -108,7 +108,7 @@ Linux内核管理风格
 但是，为了做好作为内核管理者的准备，最好记住不要烧掉任何桥梁，不要轰炸任何
 无辜的村民，也不要疏远太多的内核开发人员。事实证明，疏远人是相当容易的，而
 亲近一个疏远的人是很难的。因此，“疏远”立即属于“不可逆”的范畴，并根据
-:ref:`decisions` 成为绝不可以做的事情。
+:ref:`cn_decisions` 成为绝不可以做的事情。
 
 这里只有几个简单的规则：
 
diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
index 51fd4ef48ea1..9de9a3108c4d 100644
--- a/Documentation/translations/zh_CN/process/programming-language.rst
+++ b/Documentation/translations/zh_CN/process/programming-language.rst
@@ -8,21 +8,21 @@
 程序设计语言
 ============
 
-内核是用C语言 [c-language]_ 编写的。更准确地说，内核通常是用 ``gcc`` [gcc]_
-在 ``-std=gnu89`` [gcc-c-dialect-options]_ 下编译的：ISO C90的 GNU 方言（
+内核是用C语言 [cn_c-language]_ 编写的。更准确地说，内核通常是用 ``gcc`` [cn_gcc]_
+在 ``-std=gnu89`` [cn_gcc-c-dialect-options]_ 下编译的：ISO C90的 GNU 方言（
 包括一些C99特性）
 
-这种方言包含对语言 [gnu-extensions]_ 的许多扩展，当然，它们许多都在内核中使用。
+这种方言包含对语言 [cn_gnu-extensions]_ 的许多扩展，当然，它们许多都在内核中使用。
 
-对于一些体系结构，有一些使用 ``clang`` [clang]_ 和 ``icc`` [icc]_ 编译内核
+对于一些体系结构，有一些使用 ``clang`` [cn_clang]_ 和 ``icc`` [cn_icc]_ 编译内核
 的支持，尽管在编写此文档时还没有完成，仍需要第三方补丁。
 
 属性
 ----
 
-在整个内核中使用的一个常见扩展是属性（attributes） [gcc-attribute-syntax]_
+在整个内核中使用的一个常见扩展是属性（attributes） [cn_gcc-attribute-syntax]_
 属性允许将实现定义的语义引入语言实体（如变量、函数或类型），而无需对语言进行
-重大的语法更改（例如添加新关键字） [n2049]_
+重大的语法更改（例如添加新关键字） [cn_n2049]_
 
 在某些情况下，属性是可选的（即不支持这些属性的编译器仍然应该生成正确的代码，
 即使其速度较慢或执行的编译时检查/诊断次数不够）
@@ -31,11 +31,11 @@
 ``__attribute__((__pure__))`` ），以检测可以使用哪些关键字和/或缩短代码, 具体
 请参阅 ``include/linux/compiler_attributes.h``
 
-.. [c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
-.. [gcc] https://gcc.gnu.org
-.. [clang] https://clang.llvm.org
-.. [icc] https://software.intel.com/en-us/c-compilers
-.. [gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
-.. [gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
-.. [gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
-.. [n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
+.. [cn_c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
+.. [cn_gcc] https://gcc.gnu.org
+.. [cn_clang] https://clang.llvm.org
+.. [cn_icc] https://software.intel.com/en-us/c-compilers
+.. [cn_gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
+.. [cn_gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
+.. [cn_gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
+.. [cn_n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
-- 
2.21.0

