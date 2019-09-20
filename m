Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4DBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300612080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UbsStmVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406970AbfITXCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:02:20 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:42901 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391057AbfITXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:02:20 -0400
Date:   Fri, 20 Sep 2019 23:02:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=proton;
        t=1569020537; bh=FgubWGR7VK0H13T4Cfx7w8CE6/51UT+MOVojMhr1s4c=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=UbsStmVfQ7CZlz47zxR2xKp2xLAokH2tYWjx1nsEpTNNUSf1BUHAL1wtcf5tsqCpa
         lVsMMUr4pMxlxipUekyMMHNqNf0VKMuXChvb5w2x1c7/xifWswFKQ4t2uUsEa9p9Ht
         t3aUMJ1vrVRMy7yhxvpo77vuubZq0+HgWpKZSlxPugP5ZXEJs17M1Gji5HSqlq5l2z
         cqxxZva2WEeoipmbkcn+eIHGgmSvJX+jQVC3J+LQGHUXqVqJWWd7jYGhI4UsxaDta7
         qq/BBxr30dD0WmduZPmcCkEh8JafudHKiTFcu9e590OoJzJITIin0PlB1uhTd6q104
         xKFnWFUJzp5Ww==
To:     linux-kernel@vger.kernel.org
From:   Swarm <thesw4rm@pm.me>
Reply-To: Swarm <thesw4rm@pm.me>
Subject: Verify ACK packet in handshake in kernel module (access TCP state table)
Message-ID: <10b1fa82-4f60-6286-5129-73bdb6bfe024@pm.me>
Feedback-ID: 3r-4xLrInLN6M9PyG0idwey-nTYP2NtIrzugujjDb-SZA5fiXIYohG8L8IPXLtJh8TGI5F1ZDuZlj6I-GleTeA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First time emailing to this mailing list so please let me know if I made=20
a mistake in how I sent it. I'm trying to receive a notification from=20
the kernel once it verifies an ACK packet in a handshake. Problem is,=20
there is no API or kernel resource I've seen that supports this feature=20
for both syncookies and normal handshakes. Where exactly in the kernel=20
does the ACK get verified? If there isn't a way to be notified of it,=20
where should I start adding that feature into the kernel?

