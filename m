Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE6920645
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hkERcFjv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hkERcFjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCDL7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:59:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDL7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:59:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A52FD6072E; Mon,  4 Mar 2019 11:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551700748;
        bh=R1Xr0H/NKVgnNbfohNKDzq8vY4aVBUMDERVoqOIH5cs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hkERcFjvE88zwyedXMzT39oSoNEPbrHoRlqTLBe66i2R38G0hOVYgDgp4jGAlflnf
         PywcwZbWt6op/nZAu7l5VfjgfAilMmyJrjE8AbtGl+9UGtGQPRWCj8P2z7AEk2ZVLD
         pvbBH8TjodSnWhS6nEd74BJMJvq8cb65FtArlhz8=
Received: from x230.qca.qualcomm.com (85-76-165-27-nat.elisa-mobile.fi [85.76.165.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAE5F6063A;
        Mon,  4 Mar 2019 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551700748;
        bh=R1Xr0H/NKVgnNbfohNKDzq8vY4aVBUMDERVoqOIH5cs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hkERcFjvE88zwyedXMzT39oSoNEPbrHoRlqTLBe66i2R38G0hOVYgDgp4jGAlflnf
         PywcwZbWt6op/nZAu7l5VfjgfAilMmyJrjE8AbtGl+9UGtGQPRWCj8P2z7AEk2ZVLD
         pvbBH8TjodSnWhS6nEd74BJMJvq8cb65FtArlhz8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAE5F6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, ath10k@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Warning at drivers/net/wireless/ath/ath10k/mac.c:5625 ath10k_bss_info_changed
References: <362a9b5f-8908-17f5-3594-6c3c68789dea@molgen.mpg.de>
        <CAEJqkggKGTn0ojWzuYGfoYehDnOf=je5L-7-M1kWogutPGMg3g@mail.gmail.com>
Date:   Mon, 04 Mar 2019 13:59:03 +0200
In-Reply-To: <CAEJqkggKGTn0ojWzuYGfoYehDnOf=je5L-7-M1kWogutPGMg3g@mail.gmail.com>
        (Gabriel C.'s message of "Mon, 4 Mar 2019 12:47:40 +0100")
Message-ID: <874l8ic0l4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel C <nix.or.die@gmail.com> writes:

> Am Mo., 4. M=C3=A4rz 2019 um 12:28 Uhr schrieb Paul Menzel <pmenzel@molge=
n.mpg.de>:
>
>> Resuming from ACPI S3 on the Dell XPS 13 9370 with Debian Sid/unstable,
>> Linux 4.19.20 showed the warning below. It=E2=80=99s not reproducible.

[...]

>> [ 3018.992916] Call Trace:
>> [ 3018.992921]  ? ath10k_conf_tx+0x7a/0x4b0 [ath10k_core]
>> [ 3018.992937]  ieee80211_bss_info_change_notify+0xab/0x1a0 [mac80211]
>> [ 3018.992946]  ieee80211_reconfig+0x661/0x12a0 [mac80211]
>> [ 3018.992962]  wiphy_resume+0x7f/0x120 [cfg80211]
>> [ 3018.992969]  ? wiphy_suspend+0x270/0x270 [cfg80211]
>> [ 3018.992971]  dpm_run_callback+0x59/0x150
>> [ 3018.992972]  device_resume+0x97/0x190
>> [ 3018.992973]  async_resume+0x19/0x30
>> [ 3018.992974]  async_run_entry_fn+0x39/0x160
>> [ 3018.992976]  process_one_work+0x1a7/0x3a0
>> [ 3018.992978]  worker_thread+0x30/0x390
>> [ 3018.992979]  ? pwq_unbound_release_workfn+0xd0/0xd0
>> [ 3018.992980]  kthread+0x112/0x130
>> [ 3018.992981]  ? kthread_bind+0x30/0x30
>> [ 3018.992983]  ret_from_fork+0x35/0x40
>> [ 3018.992984] ---[ end trace 3af618ca97bd4a0a ]---
>> ```
>>
>> Please find all Linux messages attached.
>
> I reported that twice and no one seems to care about.
>
> http://lists.infradead.org/pipermail/ath10k/2018-November/012398.html
> http://lists.infradead.org/pipermail/ath10k/2018-December/012658.html

Does this patch help:

ath10k: Drop WARN_ON()s that always trigger during system resume

https://patchwork.kernel.org/patch/10837139/

--=20
Kalle Valo
