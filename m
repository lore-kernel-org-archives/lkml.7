Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F86C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019DB2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kHPh0W3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404209AbfHHRAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:00:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:49027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbfHHRAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565283602;
        bh=zZkX70dLHdMHL6hyofGaCvGcbMThtGfaPzzjiLd6jWo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kHPh0W3s0HYLWiPHLbTi2ubt/8L6En+CfHUe9GoJcmOVm3Be/7ZsV4iZvGf3ZrZid
         i9WFDVmHo6afXqjMG+yYn3Pkua2lYMmmpwHPgWo/bdqyX9scRaLTM9aib7q7zRdpDX
         IfYDmZ5iqNdY3Ixo62nvuZmNPpp7losklrEhntIs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSZ6u-1hlpdW0Mnk-00RVGA; Thu, 08
 Aug 2019 19:00:02 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation/arm/sa1100/assabet: Fix 'make assabet_defconfig' command
Date:   Thu,  8 Aug 2019 18:58:56 +0200
Message-Id: <20190808165929.16946-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808165929.16946-1-j.neuschaefer@gmx.net>
References: <20190808165929.16946-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:le7Oa6YammkW5O1nxK9SNbOka4/NAc926M3Lalyv0vd1UdL7wK2
 0cODCpflJuLU31MX1N42QwWEWWVwymlS+vhN9hd2PWZqXg5xSmJ8WYbE1SA20stCwTwz5l6
 USUFUvvv57QJGvgxy4S8+T4LFOIByTRESmQWTwV1Gujiz9f/UoH9zoMtFXxLRmz7nkABJOd
 7G3rCgrCzKQjZhNC+So2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a3MDB1l8RQk=:6MsxMj9SyaS/sHfF1sFLxG
 1nKhn5ofu6v5zeQpDxG6/V1j/f3ZrtFZumOmrNhVFk0N10FQwszQq+fNbMwa1RKvQxWoFwZ2W
 nKlE04Wdygs+3LuWoQ6urz1zvJOShYhaTKrGnPGNDzvMSmGHMl1+HxVfgcFWVa1wjhImQVuhL
 jn3Bmz1+OsM50kZgQvvNMPRh9AxVbFH5+FhrMl0vBS0hR/H4xqzhcnNEf0beG4oYXat4nDwT/
 NU98QHboozLZMQLV2Mg23v9pUwnxh3Zgg6YfeXRw6Mnp+88lsp/Ap8mrZxoxc1M4GPod7jywJ
 V473qjFTI/PiXBfZyP3SvDga7CLRt0MgDbPhhS5x+EvSq3HvuFq1lDxTvd47puV81LVwobE5P
 +QsrzVaBMr3l/VdCfCkZqB98OwPmLXxvfbBVfxtb07dX2uTMITsKNDiOLN2X6g5/632m7JJYI
 BnaatyP+UMGdRZwaRoFVDfYOp2mH3G7XtfWSwejJnP3g1NGRLI4og/MVN2/hMAOVdp8QEJgaf
 ubGxoFbfGJ/hJS9Iov0sM2WIaxy0xk456Hcw8HSVqKGRPU+0E2ko8a7VOJH0uBteGH8Nh8BW3
 E3bkvF/NeQkxm1C+gSSlbMG/NUegIpMBKQje8Vs4oFpdchu+R6Od2XiZdNl+eSfTAZmf6jBvE
 cyP+w79rA3sh+HIeVAG1MYz6ISOUJiJPwQGtBpUUrelh3BK+rMhOyYob+t9hbLAaH21I9H5JM
 0BZB+QibMQVqvtrjeX2P1oihUY2IdhcWlf4IAprHzqv3srIh/0T0XTDsEGfYQ2z3kQAdfOzS1
 NiF1KT2fJnX8BMXKf30d7KLoOR0hT5Drre+ggWpUNQlQjU70dTcYkM3VnRuXolPYo7p3mhq2s
 DW7bpHwtl3/7Ox3vzZL/Cc15v4/ZnteEy//6+r5nb5kCXgxsbKn9GWtgcQB5kRcn2rtwzN1yH
 4pTh7ty36U4ZkdN+RBtBAe4rLSancGLS4mn72Ui8n6k2l2Gzo4PZYcnbP1Qw3LigqKnrV6Mpd
 iVQZBmPORUqemd2SmurDEPyt5yFT9Cx/4mqDA7cIs4hI8KQCf/ElCDAAQLdP5p9sI2IlcFNHr
 2QgdB2TQhNJdwdB4Gm9QhFPJOPi1zOxA/ql8HU+tx234ts8ajgnt1MCVsz68Kren+TKPfzZVJ
 XZwro=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make assabet_config" doesn't work.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/arm/sa1100/assabet.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm/sa1100/assabet.rst b/Documentation/arm/sa11=
00/assabet.rst
index 3e704831c311..a761e128fb08 100644
=2D-- a/Documentation/arm/sa1100/assabet.rst
+++ b/Documentation/arm/sa1100/assabet.rst
@@ -14,7 +14,7 @@ Building the kernel

 To build the kernel with current defaults::

-	make assabet_config
+	make assabet_defconfig
 	make oldconfig
 	make zImage

=2D-
2.20.1

