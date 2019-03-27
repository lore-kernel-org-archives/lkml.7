Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED51C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE992146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553692663;
	bh=BjFoG9XzZkpiLXtKPSIyofs1qGd4Qt2+xY1fYv8QKgc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=MMz+kLzv/atR4YMyK14a9Xb4QmVmxAnbAS0werUJERd+5CDVuRBUeM+LeP1CRCjpa
	 J0rZ8IEOKei/Od2503zd+crF0zhMlJtbRhy5f6aJbb73QC+sQyQeBPWtDI3Lp8gBk7
	 yS5Ql+grJ7YfBResSHzI761+/O2ALzgBY/Ojl6tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfC0NRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfC0NRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:17:42 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC442146F;
        Wed, 27 Mar 2019 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553692661;
        bh=BjFoG9XzZkpiLXtKPSIyofs1qGd4Qt2+xY1fYv8QKgc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NZiX+ywia8/TWwDzrncmbXl9lrOczLXHfdx5kM4W+BI3cb04Be4mtr8t2YZlR6Yha
         nZ56+TS0zklrUBuMMpfTU1NU1VUCmJqJqQsiF1hqO6WW2gQPocG5OWKdyFEkGUtuFx
         crt+gta6ZQvDy93LUyDWRsqhMFFjmPeYj0rkpTZc=
Date:   Wed, 27 Mar 2019 14:17:38 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        bjorn.andersson@linaro.org, lee.jones@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Fix keyboard + touchpad on Lenovo Miix
 630
In-Reply-To: <20190326165554.17266-1-jeffrey.l.hugo@gmail.com>
Message-ID: <nycvar.YFH.7.76.1903271417240.19912@cbobk.fhfr.pm>
References: <20190326165554.17266-1-jeffrey.l.hugo@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019, Jeffrey Hugo wrote:

> Similar to commit edfc3722cfef ("HID: quirks: Fix keyboard + touchpad on
> Toshiba Click Mini not working"), the Lenovo Miix 630 has a combo
> keyboard/touchpad device with vid:pid of 04F3:0400, which is shared with
> Elan touchpads.  The combo on the Miix 630 has an ACPI id of QTEC0001,
> which is not claimed by the elan_i2c driver, so key on that similar to
> what was done for the Toshiba Click Mini.

Applied to for-5.1/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

