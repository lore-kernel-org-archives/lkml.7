Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2100C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3AD20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfCFKyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:54:25 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:37525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfCFKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:54:24 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MowT0-1hJTvh10Fa-00qRCV; Wed, 06 Mar 2019 11:54:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     netdev@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] appletalk: Add atalk.h header files to MAINTAINERS file
Date:   Wed,  6 Mar 2019 11:52:37 +0100
Message-Id: <20190306105249.2165038-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190306105249.2165038-1-arnd@arndb.de>
References: <20190306105249.2165038-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JMQw8Awr6G37WwGOfVRwI4KS6Q79JUrX0ye3tEGwB2Is07dQswW
 U096LGjc11M2HHZMAX3ztLB8/5+mJbdkvUI8woQVTwTSxn6RguLYCVckjBwD7yrlyqui/4Z
 BxDILTNak6DlObJ38kVO++ov1t158Zz67G1vN+bXyM7g+Nlh9BuvhcA/2mAfZ88yiJUsOCf
 hEMdij6/nKTq1HTm39VrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CWyEpVprRso=:lEics7Ifb7ACrlAX8wzrvJ
 qOYakD+39zQIZzmBhXlr09D0bcsnnGnu9VBauOHWiACVcj7BxBZugNOgX0rVJwNLgkj0kuwv+
 /l0YRuHLLnCW/I8fHgTAkmNfDJJlrYzFmxpfi5Gzo8LmLfDHLlwDDi0rJr/DXZgxjGjDr+Cdn
 XLLGoSOMcRiqmQv9M7wUl5lTDRzwOqspuiLAfFhP3nz3eorzynhmCVrX0pTapkUC7SO24Wnbt
 3dQz6VcHbbMWv1RYYsiamxnSBOmGEk181cCUcQczYtkbnMQib36nvaBYhUbIciUVlBkeCn+t5
 /GwMHnn0p0mo706YEnVMOD7RS1atmRP4yj0135eBUKjV2qMtya5Bol5TjvEqRzX/tTZZsRIag
 QdQVVtiAoON12Nrm65yW6fMvFjqZHeZcX+n8Henacdsvqjiz69zrHbRNDwqgJUpnYadqMA4nj
 BaXRqQoXc1+y9d1MOEVjvFHLD2W49F24REwCAqtitZkM0KWBHonSkuveafi+5ZJBWrjVGHtdm
 fMKxU7OKu3CuoeYHJelrMKroYdwdsqZz6rmI+qeomz79bnLvxtcx5ikmyTriN68x5iTMzoqRn
 KYgtqgSEGKTsTXmc7qYhxVocwd1s/pIOnqAMrryEjxUDhhrVno0QlVT2K0Ha52/IaV7qQQn0C
 pHbK8LqbETU2cM8SYEx49zLf8Epli1GHeaow0x5GYSDXawOhY6kyMRHDxzE2jvdP7qg57S/Cu
 /OthPbCbMj83kjE/s6DUgWsCGdH7s2r2gVz1fA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the path names here so that git-send-email can pick up the
netdev@vger.kernel.org Cc line automatically for a patch that
only touches the headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e64279f338a..1f344f0c2254 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1059,6 +1059,8 @@ L:	netdev@vger.kernel.org
 S:	Odd fixes
 F:	drivers/net/appletalk/
 F:	net/appletalk/
+F:	include/linux/atalk.h
+F:	include/uapi/linux/atalk.h
 
 APPLIED MICRO (APM) X-GENE DEVICE TREE SUPPORT
 M:	Khuong Dinh <khuong@os.amperecomputing.com>
-- 
2.20.0

