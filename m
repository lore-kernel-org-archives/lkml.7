Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FDCC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5EC2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgAFWHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:07:05 -0500
Received: from blaine.gmane.org ([195.159.176.226]:46482 "EHLO
        blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFWHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:07:04 -0500
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1ioaWZ-000H3z-Ch
        for linux-kernel@vger.kernel.org; Mon, 06 Jan 2020 23:06:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH v1 0/3] Add virtual serial null modem emulation driver
Date:   Mon, 6 Jan 2020 22:06:50 -0000 (UTC)
Message-ID: <qv0b1p$m0o$1@blaine.gmane.org>
References: <cover.1578235515.git.gupt21@gmail.com>
 <be5b7b29-97e6-41ad-7ae8-cff83dfab95f@zytor.com>
User-Agent: slrn/1.0.3 (Linux)
Cc:     linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-06, H. Peter Anvin <hpa@zytor.com> wrote:
> On 2020-01-05 23:21, Rishi Gupta wrote:

>> The driver named ttyvs creates virtual tty/serial device which
>> emulates behaviour of a real serial port device. Serial port events
>> like parity, frame, overflow errors, ring indications, break
>> assertions, flow controls are also emulated.

Brilliant!  I've wanted that for decades.  It would vastly simplify
the implementation of some network-attached serial ports.

> OK, I believe I have asked this before, at least when this has come up in
> other contexts: any reason not to do this by adding the missing elements to
> the pty interface? For fixed-name nodes, the legacy PTY interface is basically
> what you need.

I proposed doing exactly that many years ago, and I even offered to do
it if there was some indication it would be accepted.  The offer was
ignored, and I never got far enough through the PTY code to determine
if adding the required features would cause any problems for existing
PTY users.

-- 
Grant Edwards               grant.b.edwards        Yow! What PROGRAM are they
                                  at               watching?
                              gmail.com            

