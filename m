Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A59C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EBD20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="xQHHDT8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDCLYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:24:31 -0400
Received: from cock.li ([185.100.85.212]:41702 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDCLYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:24:30 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1554290667; bh=45bvdyLfGpzypB/QzrUMFJvAvnMqRNIWkW1pumQtoMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xQHHDT8yjYRgds47U6oKLPzcJCjN4x17avV1DjQQUh9bveleSgJuC2R69HpeRyuvn
         EFImFoPqxpgHgrf/fdebv51tKEyrzMVHR0Lq0iCxjHtv6+5cFmSuoSgxTM7tZl2w/6
         j5MvySnKeCicNoFDxwtH8n5WtIQZ5MH/8GpZqFyLKmCgXM4FLX8j7vltzGCebiiPhb
         YWsZpQnZNwC+VCoA/+anzl1OCT9QoCk6aEpZeYI2fgXdlF6UAJaQ5M7Six2r7b39A+
         v0k/qlRbeHCxji9AAlqyQH3aXwVQqMuqEs6ZvkY/+enDSzWNuQ9AiUA/U83c0yb1Eo
         GgVWexdEx3ahw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Apr 2019 11:24:26 +0000
From:   mikeeusa@redchan.it
To:     GitHub Staff <support@github.com>
Cc:     linux-kernel@vger.kernel.org, esr@thyrsus.com, misc@openbsd.org
Subject: License revocation from GitHub and GitHub Staff (regarding GPC-Slots
 2) Re: DMCA takedown notice
In-Reply-To: <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5870232@github.com>
References: <5c51daed7c023_2fcf3fe7576d45c417207b@github-lowworker-89d05ac.cp1-iad.github.net.mail>
 <5c51ee838b18f_74e53fd6ff0d45c41780e2@github-lowworker-5909e27.cp1-iad.github.net.mail>
 <5c522f5b6cb8a_60733fc5256d45b412831@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c534f0336ca6_19ae3fcbf5cd45b4186161@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <5c535110f0f30_3aa13fafe46d45c4222962@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <061a28afa26cf5ad7d11f8074353a9cf@redchan.it>
 <5c5489478eb20_56f33fd9e9ad45b43146ec@github-lowworker-4f62d42.cp1-iad.github.net.mail>
 <5c55ecdcb298_3a283fd6dfcd45c4309246@github-lowworker-63e61ec.cp1-iad.github.net.mail>
 <5c563190ae6cc_18c33fcb464d45bc1523b0@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c586b095281b_4c6d3ffba28d45b8120450@github-lowworker-e51511d.cp1-iad.github.net.mail>
 <5c58a56f8ded7_36e93f9cb4ad45b8932e7@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <312c3d91f6c4a71c34b96728a2efb385@redchan.it>
 <5c5b1609a1561_1ac23fbe2d6d45b88762d0@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5812163@github.com>
 <d6326acd7a9a52a5cf4de2bd3841fc5c@redchan.it>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5851873@github.com>
 <1ad00463db02ac58f89c4ac99b2299e4@redchan.it>
 <CAKSHBJW4qkrozz0HrWvXnbpHicSBRoRKycC7xBoK0uWZJx5NkQ@mail.gmail.com>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5870232@github.com>
Message-ID: <4d888cf10279eee33b6f4a3b2e7c40a6@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have, at this moment, chosen to terminate any permissions GitHub and
the GitHub Staff have enjoyed regarding my protected work (GPC-Slots 2).

Any allowances GitHub (GH) and the GitHub Staff (staff) had regarding 
GPC-Slots 2
(the work) is hereby revocated, rescinded, and made null.

The allowances memorialized in the writing known as the "GPL" are
rescinded from GitHub and the GitHub staff.

I am not in privity of contract regarding the licensing and
distribution of GPC-Slots 2 with GitHub nor any of the GitHub staff,
nor have I ever been.

I have not been paid any good, value, or consideration for the
dispensation of the permissions.

The permissions are freely revocable by me, the Copyright Holder, in
furtherance of my pursuit of my various exclusive rights regarding the
work, none of which I have transferred or contracted away for value.

Should Git Hub or any member of the Git Hub Staff choose to defy my
wishes, regarding the work, I will seek remedy at my pleasure: both
against the corporate person and in their individual capacities.

Signed;
--MikeeUSA--

Note: I have posted this notice at the original place of download, of
the work, lest there be any contrived confusion regarding veracity of
person or pleasure.


