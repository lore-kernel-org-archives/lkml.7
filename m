Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D018AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A932085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552916910;
	bh=lZA1Z8eLRWmPJi1qSZLvxW92d6ZW7lCwwlJrtYVlBHo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=GCo2AJPITl9vcOxCk3U4OpuRDZCo6ub87Pj82TRGujpJYkxD7HYuSC8hyPDuUiX1k
	 rozgUyncNb1CqRTfkn8WNBvmaOagvi9DUA22tmEl56OasC2n/hAnPW29rHgrEtRa0/
	 keNZPk0y8ljQD8WYFrUMXMGXniVmFgEXvQiFobyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfCRNs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbfCRNs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:48:28 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD7F2085A;
        Mon, 18 Mar 2019 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552916908;
        bh=lZA1Z8eLRWmPJi1qSZLvxW92d6ZW7lCwwlJrtYVlBHo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NuY0fTo3JWHz6XLVkgTQe18MCYbATS3MBMZkrXYCKOvSpiQ5N9g2WMCrugRhllD+S
         LiAAxxSgD49zPJ0SQN4DTJP/PLqP4mF+d1BqQaaHEnA3N17M+lT2QCmR191aoXugFF
         QhGHsDav5TYm96lkRkUIJ8wM8cRSZpOtbkWg6+Hk=
Date:   Mon, 18 Mar 2019 14:48:25 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Increase maximum report size allowed by
 hid_field_extract()
In-Reply-To: <20190308051117.21899-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.1903181448180.19912@cbobk.fhfr.pm>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019, Kai-Heng Feng wrote:

> Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
> to 256") increases the max report size from 128 to 256.
> 
> We also need to update the report size in hid_field_extract() otherwise
> it complains and truncates now valid report size:
> [ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract() called with n (192) > 32! (kworker/5:1)
> 
> BugLink: https://bugs.launchpad.net/bugs/1818547
> Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size to 256")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

