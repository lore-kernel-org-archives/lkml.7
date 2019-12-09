Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10CBC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B005C207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575896039;
	bh=5gQZ0Npr+vj0kuQouIRe1sRdPp/CgVRkEAKoJoYgByY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=MQPJtsk1qEAG+gDL/NpTnlRuO9THSO/rPW+CY3g8QhaZBpcqcOeeROfQ/U24guoVZ
	 Z7ynScHQ61K0DuspMDjXYCxHQ2uDhEuj+ZVPZ+8Bx4eEMV2HB5g+rnNOftSR1cQeAN
	 5+KvjYcDDltRWVSNk5zoGkVbw4QrCMjGtxO1EGUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLIMx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfLIMx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:53:58 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922862077B;
        Mon,  9 Dec 2019 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575896037;
        bh=5gQZ0Npr+vj0kuQouIRe1sRdPp/CgVRkEAKoJoYgByY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=h+g1QDvdRwmKRVQxwehRqPuR6dfX6nuYgCrDna3im0PRopLDJ/2ip5jrKO+9rEoRw
         eZYmfR7bbXGgUa+UoFLfCchXuK/+syWIS+hrttehSUGzRNuZw9EaJozp72MCLqbiA5
         8KXOUiEWQKKT9hGPEgDnPIfW9U0LPN4WPzvzVvzs=
Date:   Mon, 9 Dec 2019 13:53:54 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
cc:     David Herrmann <dh.herrmann@googlemail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Fabian Henneke <fabian.henneke@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uhid: Fix returning EPOLLOUT from uhid_char_poll
In-Reply-To: <20191204024355.4566-1-marcel@holtmann.org>
Message-ID: <nycvar.YFH.7.76.1912091353470.4603@cbobk.fhfr.pm>
References: <20191204024355.4566-1-marcel@holtmann.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019, Marcel Holtmann wrote:

> Always return EPOLLOUT from uhid_char_poll to allow polling /dev/uhid
> for writable state.
> 
> Fixes: 1f9dec1e0164 ("HID: uhid: allow poll()'ing on uhid devices")
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

