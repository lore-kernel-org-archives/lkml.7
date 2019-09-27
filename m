Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59C0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C5320872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ungleich.ch header.i=@ungleich.ch header.b="GgU3/wQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfI0LwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:52:09 -0400
Received: from mx.ungleich.ch ([185.203.112.16]:32846 "EHLO smtp.ungleich.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfI0LwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 07:52:09 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2019 07:52:08 EDT
Received: from nico.schottelius.org (localhost [IPv6:::1])
        by smtp.ungleich.ch (Postfix) with ESMTP id A2312202D7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 13:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ungleich.ch; s=mail;
        t=1569584680; bh=OEKFUnI+eYxrzM6ELCjE7ZNlBhL2JIJJo9kNg5UFR1k=;
        h=From:To:Subject:Date:From;
        b=GgU3/wQQK1GXQZyiZLVQ9nbGy42GH/JN2tjXcX83evp5ka2RKZYFdp0SSVSN4VxrE
         eCak1mnfbWhjTidbvllS1BmGVDYzT9OYbunWOGLhKEnqyyxaLfbsE3r+B6lLXJyZzg
         S9J3OGlVY3qrQ/W76K78E756rIjiOsqWhVgJYJ/o=
Received: by nico.schottelius.org (Postfix, from userid 1000)
        id 9AA771A01027; Fri, 27 Sep 2019 13:44:40 +0200 (CEST)
User-agent: mu4e 1.0; emacs 26.1
From:   Nico Schottelius <nico.schottelius@ungleich.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Kernel panic on new Dell XPS 7390 (5.3)
Date:   Fri, 27 Sep 2019 13:44:40 +0200
Message-ID: <87a7aqnetz.fsf@line.ungleich.ch>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Good morning,

I have just started fighing with the new Dell XPS 7390 and get various
boot errors [0], including a kernel panic with kernel 5.3 as shipped by
Ubuntu 19.10.

I was wondering if anyone has an advice on how to debug this best?

Best,

Nico

[0] https://twitter.com/NicoSchottelius/status/1177540293454979072
[1] https://twitter.com/NicoSchottelius/status/1177545177193254914

--
Your Swiss, Open Source and IPv6 Virtual Machine. Now on www.datacenterlight.ch.
