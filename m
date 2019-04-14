Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F1C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C922084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 14:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UEQyhNI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfDNOAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 10:00:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:48733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfDNOAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 10:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555250402;
        bh=XcUtHedjYwTU7VORv74GFUY8pHZ9GSQ1ogiVwt6N3J0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UEQyhNI2Fb2IfyR2wnbm+BfCzeHKJuQxCJrBSTijTw/1v03kvAZ4xYcjAFFYhul6i
         ly+w81D78x1reG/KEimCrnIkjscpZ1C1KXI0PGOgH4EyzXQrD0uAKl9EDe82iZ1iMr
         y3KPW/6cpGtXk++W/0w1+6dOaBJqCpno/T7bWRtc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([113.87.90.122]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MhMg2-1hSNF51TSU-00MeIo; Sun, 14 Apr 2019 16:00:02 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] quota: remvoe redundant variable assignment
Date:   Sun, 14 Apr 2019 21:58:55 +0800
Message-Id: <20190414135855.2536-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:Xs6e9owLTQmHFAFK9QqvdroAZV8+OBE07y3arqzR7xLSbtMeKW+
 wMoP8RDKEGGQy9JVIuGSkqXPfstQUbEDkbNcy26oz7n+juKvEjVmBTfVuU2aszY8JPyh5TI
 JgWZNd2nEQn+16JvSQnPl9U+HRnUxx/Nk3HJRNzKndtrEIMQk0mK/AxSYEqKknWGa57K9Ci
 uXkJxQx9HMWpzkiYgSFCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tYcT0JSLpWY=:he2ddwM+db8XwP4Q391RHE
 gViuc//cvuYyMw8nKTQT5Sgl2RCIiKBrI6L/OP3nk396+ac5bwtg1gbHjG9umJE/n5QDwG2cf
 uIijSktL+XenCjvMLGD8SMxn8WTRNoI+csuHa9HR8JK67/WvCmuj+rMZeQnNrV3We3juxmILV
 GWrHYpnn1VCGcXtfRfAxjcHFGVmisEvFfJZ9UOmGr6oLMU83pFL2IAwQXZxgIA+yYz6Aa62il
 /RlM2h681qqZrXqwnQ2zzrd9QiGQLm98vtyk/EBElGqbAD/krgH39ipbphzwLcD4MekxUUG6+
 d0ZZ8gaPp0V/4R1+dOH9eDCW+9H0WXjKr4enCzo9k0Yb9PlhwVusvCDr9xK7c+fBict9ZMJZQ
 mb8zM3gGqwvL4H79BBv2m2aM5DLKQMe9Sb3vG3uR3Q5otkOVG31zUfzeP5/0MJ6yg6CJ0hRLf
 90yNXZNtS/yUEtxFnwghb0e0qnKizZmVFnQ7iRM4TM5dwa6xfvuCOmDv4SFdCNTTEEn63NBAM
 bTR7XiUGHrqlazOL5eXIaUNzV2sqEt/2S6Qh4NYRsL850MZ2dCZFdoePuUL7XL3HWPy4+FWlX
 CwEdvH6bxjbqDr5AWxx8MtWiv4CLjLFCneXFPzrNo53XQJu8EUt2CZFDS2BjL4V94yJd5/624
 lYJfX8eBR3xnkievnZyrDvbsyZ0uvqB/hjFxtZcubaghkMqCEMwvRMqWGgwxYhYgEDgIVDGz9
 I5InGUsQaTmwFxQFLPCVEXYcvYmIAz7vWysmV/UWOvyxa9lz3CuAp8DVKB7bcsb+J8Xw9IN7Z
 lVPRCaRJcoB8j5NP42ddAAGM70sp03pHRm4A1QrrIGPLxpbeF/FxpX0Ixd/GnnnwwfcPnuoqw
 M3hI8gXH+SYQh2Fh2agi0fZzXd4Bglyq+q7dVjlrodvkJqYqv4qFcGmQ5ufh58
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assignment of variable ret is redundant because the
value of ret is 0 after calling v2_read_header() in normal
case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
=2D--
 fs/quota/quota_v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index a73e5b34db41..25d36607be6e 100644
=2D-- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -158,7 +158,6 @@ static int v2_read_file_info(struct super_block *sb, i=
nt type)
 		qinfo->dqi_entry_size =3D sizeof(struct v2r1_disk_dqblk);
 		qinfo->dqi_ops =3D &v2r1_qtree_ops;
 	}
-	ret =3D 0;
 out:
 	up_read(&dqopt->dqio_sem);
 	return ret;
=2D-
2.17.2

