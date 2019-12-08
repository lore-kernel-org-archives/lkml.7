Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB99C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 19:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B0E20637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="ISvUDzFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLHTvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 14:51:22 -0500
Received: from mx1.riseup.net ([198.252.153.129]:52532 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfLHTvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 14:51:22 -0500
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 47WH3c12sHzFbvT
        for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2019 11:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1575834681; bh=0M2lhcy2FYKm2+SRcy2Jci43Ev7ErwxC8T+bMBjcfik=;
        h=Date:From:To:Subject:Reply-To:From;
        b=ISvUDzFnItbD0bNDn62oTA2mEdzaZdVP5AvpL9JtFgWl3qT6t9WOKkSGBn78w2ZeL
         1Q7jP96Z+lJMsOiu/GK6Y2YqhFLTi4gekZe+We6zQt0gf555cYBQyEJdjC7ZJQw+cX
         ndKGPGItsgsGNJFWmm1MisdGRCpXmF6Oa0KI36Ok=
X-Riseup-User-ID: 634DB24322CA60189C9E3EAEA1F5EC3CD39959FC527EE276F8B7AE03BDF39587
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 47WH3b2gqMz8tYk
        for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2019 11:50:03 -0800 (PST)
Date:   Sun, 8 Dec 2019 21:49:58 +0200
From:   Kernel User <linux-kernel@riseup.net>
To:     linux-kernel@vger.kernel.org
Subject: CPU vulnerabilities and web JavaScript
Message-ID: <20191208214958.492988dd@localhost>
Reply-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel developers!

I have been looking for information but I couldn't find the answers I
need, so thought it might be best to ask the experts first hand.

As soon as Spectre and Meltdown were announced in early 2018 I got
paranoid. I am not a programmer per se but my understanding is that the
main security mechanism in computers (isolation) is not reliable any
more and there is no fix for it - only mitigations which are not
available for all vulnerabilities and for all CPUs.

So I instantly blocked all web JavaScript in browsers. I don't want
anything creepy reading the contents of my RAM, my passwords, keys or
anything else in a way which it is not supposed to. However without JS
web (and life) is difficult and for some sites (e.g. online payments) I
must use JS.

So what I do:

To minimize the chance of any JS reading anything important from the
contents of my RAM I "simulate single tasking":

1. Close all open programs

2. Clean clipboard contents

3. Lock any open keyrings

4. Enable JS for the particular website only (one window, one tab,
incognito mode, all history/cache cleared beforehand)

5. Do what I need on the site as quickly as possible.

6. Close the browser

Of course there are the processes running in background. I am also
aware that closing a program doesn't necessarily mean it wipes the
memory it has used but simply makes it available for other apps (i.e.
memory contents may still be vulnerable). I also have no idea whether
the login credentials (of the current system user I am logged in as)
are somewhere in a vulnerable RAM zone. IOW I realize my approach is
incomplete.

So my questions to the experts here are:

(1) Is what I do reasonable, meaningful and does it actually provide
any additional security? (assume a CPU with, or without mitigations)

(2) As experts knowing the intricacies of all that, what is your
approach and recommendations regarding usage of web JavaScript?

*NOTE: I am aware that web-JS, even without vulnerabilities, has
additional privacy implications but I am asking only in relation to CPU
vulnerabilities.

Sorry for the long message.
I really hope you could shed some light on the subject!
