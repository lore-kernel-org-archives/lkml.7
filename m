Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E79C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D622070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="jIPUjsk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfCDWtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:49:42 -0500
Received: from tomli.me ([153.92.126.73]:44216 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCDWtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:49:41 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id e8e005d4;
        Mon, 4 Mar 2019 22:49:39 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Mar 2019 22:49:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=1490979754; bh=GSa3KMva/o8J+I3L/EUsctik2qztdvPyjYisCxkTpxM=; b=jIPUjsk9CN21Sn3zARzKZ0QHnC+ksIbhohIwbjXh5yLPzecdOWqkX/1mQbxj0tawiCqKUQstp74UE3slNqiCqj/fW3al10UV+LYDsOP8jGHmc6VSD4fgOX6HaRHVYU9bDMWT3FJM5JLoPl2M3dTdYZ9pOM2fMudEIZunyhLvkYOM7hDcYXp/jfk/zYh0kaNq7sxw2uRd8v3adVg0OoIUYdkfgcdXvWKzKJrPGpzZ6LVKWUUC3xD91SHDfmOkG8+eSBqshP4H3YBrBCe9fw78Ez33tPrMuzJlcAl8/SSWJcbpMywQptNDLbr9uGQaIYISqxzppeE0E4+mywzxJF4Jaw==
Date:   Tue, 5 Mar 2019 06:49:32 +0800
From:   Tom Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: MFD/Platform drivers for Yeeloong laptop submitted, please review
Message-ID: <20190304224931.GA25280@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Paul & Jones.

I've submitted the first series of patches [0] for the platform
drivers on Lemote Yeeloong MIPS laptop to the mailing list, this
series is required before the following mainlining can be proceed.

The first patch of this series is a MFD driver, which is needed to
be reviewed by Jones.

The rest of the patches is the required changes to the board files
in arch/mips/loongson64/, which is needed to be reviewed for inclusion
into Linux/MIPS. In addition, there is also a trivial bugfix for
suspend/resume, which is needed to be queued into mips-fixes.

I understand I shouldn't have sent this mail because it only adds noise
to the mailing list, but in this case, unfortunately, it seems Jones
never received the original patch, perhaps my mail was classified as
spam or rejected by his mail server, and in fact he didn't even realized
the existence of it... [2]

Jones: I sincerely hope you've receive this mail. Also, is there a
mailing list which can be used to submit MFD drivers rather than
CCing you personally? (in case the mail has been dropped again)

Thanks for your time.

Thanks,
Tom Li

[0] https://lore.kernel.org/linux-mips/20190304222848.25037-1-tomli@tomli.me/T/#t

[1] https://lore.kernel.org/linux-mips/20190304220022.20682-1-tomli@tomli.me/T/#u

[2] https://lore.kernel.org/linux-mips/20190302175334.5103-1-tomli@tomli.me/T/#maabd498c419c13a5435231303ef803a71451af8b
