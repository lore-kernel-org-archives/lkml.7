Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BB0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2328F2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Z+uVRsdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfLKRKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:10:17 -0500
Received: from sonic301-22.consmr.mail.gq1.yahoo.com ([98.137.64.148]:36024
        "EHLO sonic301-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730129AbfLKRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1576084215; bh=zh+Qq4KKIZBWaPq05JcdqJTq0ZIdb2xT9gPdRoh6Iu4=; h=Date:From:To:Cc:Subject:References:From:Subject; b=Z+uVRsdHOXjOjjD9kXgyXgiLKGsj3ENObF3fxk7XwSy5K80VnFlmWQ4RYKetMSFs0vYkLW+LzHhOghKRoY2OoA6sa5kwxCrJwy7dCBCSBr8zyBNP+T4C22OTdEnxxICWIRkkHw9/kSByzfdu62QDKpe3pQFPmGV6QO/zh/Pt7l0mtjbAh2nki4PCXinp574TEXo0dHWm/NqyAYpL7qg+/fkQIK90+Ou7AAQ6/kTxpppRi14EScK12dij6bajPtWdkhIYrBHIA54URZ0k9YSN6arXRJg1dlfTCVxfW6Lh/zc4GDdWfv+qcDJFhx+F3V0V/8CG1YMlVusWrWoogYtQQg==
X-YMail-OSG: WG8ijLUVM1kklRgyAHjAJW0GX8ixNnkB.BQrGKakTRErvtKWMMgVhn1zd2ZVceK
 NdtyTOS.pE0VJ3X0j0YcdgenF4f3E_Yz8F7H4SiHQlMn5m46Lj8i.j3Q4_g9ONYm4OauQq9L0m_K
 ERLQxrsbAqEL.T1z9NKHmvAjaVpHVbZZ2rPNOzPMzunok6QfhV7miYZhGWkUgf3Gx2az1pYr_8Bz
 w_7K8OLUTex5GtLM38kK9sHSgvU8Gf_CGNX94RcTscCpUhhrCPqdjovKewaDtTojK17UE20OKDL8
 ygnY5ed_cA6oT27gzyKcf55Lwr4_551HdcvJc16AW9.yf3p60aboUwMZNGKDkgxG5RFw5CFlouXo
 3ya7tVxa3LaxAEgZiWb0Lb9MAXPNqpC0DB53NMyfW9Os70jG9ibKkMz_DYvxyKmph1GynRg5KLqE
 ovsNgOiXXYKkoplpnKDnzOuAP9t9DQXggapzFvR2rSuSZdXTYlv3t00Ob_rvk6KNkAVY1W0rBJb7
 Dc9encw4cYxTopFCQ5j_aAnv4kBE4bXtI6PQhptegeACwIbLRAqv9CuPlrhEwWbNYXIB8g4zp6I_
 jYKBNbK4oBUjUk7YcHi2gPqUd.U2uFmhBNM8sbzlGPrkeFKy6fFEJt41Mkfi_6lGbn_aofA8xIJZ
 ceY9hSCoUtBN_4EWIeT75aHow2.J4N98eW2NgkW_4.k2fdgDVMWcseihOeyxCx2RFkbxsd9KdLsg
 j_glcQtModUuCYoNeNR6JvZkLpvyLURWiL050PEwLk.vRMBr0_l_AGCz0OmYpPbR9jCNAyfdEhhl
 KtPQ0J98Q2PqhDx1.a1U5tY_aSnis19.hlcB9oV1Kkq_yHaVbnERSdp3dFVlISxTo_Ki6bzDNdTm
 9SbyWYt3quGH6JFZaYcV4dmqOHH_uvEjJqcQL2gPmpsDBeXfEVkUlswcR4LVD9Zt19LSJK5wTsO6
 PBjIXfgDnE4HETtrwZijzELnoRTbj6hl18XmBEmV7wHbe4i4WUYyKZ3MFfRia6CX96e.uCYd3gEu
 8IQcrQeSNQvsrFvwdrsgDdBOEd4LDndHg5JmRwFncasxCmzt_m.4ETAJYcjFPQMrOntdflK5lIFb
 AzKm.lz.TSGFbxX9io7cq_.IpF7aEZ.JOxffZdntPQ3O.QIUfzDMkzzudZuvJLgrBCodCEVSzOIX
 ffrXtZ5wkcWoANy8mBzvR1VQ91jSswxIPPTvH671QZrrpaC8ei5arEUFB3LMXSw68UPLwE4_zUSE
 hnHs6gNXvtyynnkdkTyWZ2BFitDQUBhyYbuM4A81pAGH80hI_NIRfbtR7tq8aH4iP6MmsBRncc3m
 _33mUcV_GPkTNmc_Xme5PPcskO6boB2jFJmNE1AQrqWIT6ZsO1FgPHA6oJzzeZNxFgYx83jARxwL
 loPCHanaSMSkb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Wed, 11 Dec 2019 17:10:15 +0000
Received: by smtp413.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 78b50f606b195eafc3a6178574d6a883;
          Wed, 11 Dec 2019 17:10:09 +0000 (UTC)
Date:   Thu, 12 Dec 2019 01:09:58 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Michael <fedora.dm0@gmail.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Wang Li <wangli74@huawei.com>
Subject: [GIT PULL] erofs fixes for 5.5-rc2
Message-ID: <20191211170950.GA16027@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20191211170950.GA16027.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these fixes for this 5.5 round?

Mainly address a regression reported by David recently observed
together with overlayfs due to the improper return value of listxattr()
without xattr. Update outdated expressions in document as well.

Thanks,
Gao Xiang

The following changes since commit 219d54332a09e8d8741c1e1982f5eae56099de85:

  Linux 5.4 (2019-11-24 16:32:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.5-rc2-fixes

for you to fetch changes up to ffafde478309af01b2a495ecaf203125abfb35bd:

  erofs: update documentation (2019-12-08 21:37:01 +0800)

----------------------------------------------------------------
Changes since last update:

- Fix improper return value of listxattr() with no xattr;

- Keep up documentation with latest code.

----------------------------------------------------------------
Gao Xiang (2):
      erofs: zero out when listxattr is called with no xattr
      erofs: update documentation

 Documentation/filesystems/erofs.txt | 27 ++++++++++++++-------------
 fs/erofs/xattr.c                    |  2 ++
 2 files changed, 16 insertions(+), 13 deletions(-)
