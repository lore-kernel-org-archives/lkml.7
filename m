Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956DEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C462147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554297068;
	bh=yCaCA65SXLLFano/jsUinAERfun4BTYm7o94zUV1KSA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=wdABY2wvXsncwLp3viXDl29jDolkWlDewLjA4zvwSqv6Go3UYSsM3LCcaUwNFrLv/
	 3rxzvHmx+f9iiIQnXqR7GHoNpUGNaTMmbiubx1kLH5Du5s0eM/j1xbjqAD27miWmF0
	 TjPw/gDjfdsKb0eekeQmpvlClKlHa9ADuBQGF78Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDCNLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCNLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:11:07 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA4162084B;
        Wed,  3 Apr 2019 13:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554297066;
        bh=yCaCA65SXLLFano/jsUinAERfun4BTYm7o94zUV1KSA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=bwvHb1fzVsikKzbtncUnVurJTES7iBI0VLxuYtCL5Fqg1eYUcKUOmv0Pdib1eo84D
         efKBYlOeO7v0Dx9DzZ/fVXFRgsIhzAutRRKZrGDzw1U2HtdWap59whwm+LXgMbKBzo
         e2texBQapS5ElseIsMgz3NewWdPbtgfTpQqo6nYw=
Date:   Wed, 3 Apr 2019 15:11:02 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        ncrews@chromium.org, jettrink@chromium.org, gwendal@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5] HID: intel-ish-hid: ISH firmware loader client
 driver
In-Reply-To: <1554184061-2872-1-git-send-email-rushikesh.s.kadam@intel.com>
Message-ID: <nycvar.YFH.7.76.1904031510430.9803@cbobk.fhfr.pm>
References: <1554184061-2872-1-git-send-email-rushikesh.s.kadam@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019, Rushikesh S Kadam wrote:

> This driver adds support for loading Intel Integrated
> Sensor Hub (ISH) firmware from host file system to ISH
> SRAM and start execution.
> 
> At power-on, the ISH subsystem shall boot to an interim
> Shim loader-firmware, which shall expose an ISHTP loader
> device.
> 
> The driver implements an ISHTP client that communicates
> with the Shim ISHTP loader device over the intel-ish-hid
> stack, to download the main ISH firmware.
> 
> Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Acked-by: Nick Crews <ncrews@chromium.org>
> Tested-by: Jett Rink <jettrink@chromium.org>

Now queued in for-5.2/ish. Thanks,

-- 
Jiri Kosina
SUSE Labs

