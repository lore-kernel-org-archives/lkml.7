Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C59D21920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569933745;
	bh=pSkMpm9s9s1x//p/Xrcv+CAX9qBFD5KnYugqHGJyNDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EW3h8REyZBJAqOSjJStYGD131h1ElFyiEYmS1Pn5pnM3dlUSVLDvbqCjTu5UPyk65
	 GD0IpNMhqMGkXeY0Svbbt7UqFyCTumJ4bWKtKMGHqSNMX5Ji/pPDClV3IZDnps0D7l
	 27OG5PI7BGBQmOSfdrXDcB2w3/jgruIxydhO0RKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbfJAMmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJAMmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:42:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B8020842;
        Tue,  1 Oct 2019 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569933737;
        bh=pSkMpm9s9s1x//p/Xrcv+CAX9qBFD5KnYugqHGJyNDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SwixsgCpVZ8cc6eqyAZX2gvh3aCkU04HIqqY7NP5KZvVDlnRiPF2YYjIVYXCGuOK3
         m2nGQhkIQe4v/sQ+RpV9iqaNwTVLQ9iEd+IuF24muhkoUHr8/tPG5UQhfO3GbYG11h
         agN+B0irg2ymLPuDcB4WQiqrgmiBDV8CGaTdJESo=
Date:   Tue, 1 Oct 2019 14:42:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 11/22] thunderbolt: Convert DP adapter register names
 to follow the USB4 spec
Message-ID: <20191001124215.GF2954373@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-12-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113830.13028-12-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:19PM +0300, Mika Westerberg wrote:
> Now that USB4 spec has names for these DP adapter registers we can use
> them instead. This makes it easier to match certain register to the spec.
> 
> No functional changes.

And here  :)
