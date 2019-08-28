Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ADCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BA020644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfH1Ru7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:50:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:15987 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfH1Ru7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:50:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 10:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="197616649"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 28 Aug 2019 10:50:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 28 Aug 2019 20:50:51 +0300
Date:   Wed, 28 Aug 2019 20:50:51 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Dan Streetman <dan.streetman@canonical.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Kay Sievers <kay.sievers@vrfy.org>,
        systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: Follow up on hid2hci: Fix udev rules for linux-4.14+
Message-ID: <20190828175051.GK7482@intel.com>
References: <CAOZ2QJOZStRYa=5fyod_AEJcJQw90_yX40dPYY3Dhvfso1e=RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOZ2QJOZStRYa=5fyod_AEJcJQw90_yX40dPYY3Dhvfso1e=RA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:34:07PM -0400, Dan Streetman wrote:
> It looks like this patch got lost at some point:
> https://lore.kernel.org/patchwork/patch/902126/#1138115
> 
> but it seems to still be a problem and I'd like to pull it into Ubuntu:
> https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1759836
> 
> Ville, did you ever follow up with a v2 for that patch and/or do you
> know if it will be accepted soon?

There's a more recent version of that somewhere on the mailing list.
The problem is getting someone to actually apply it. Seems much harder
than it should be...

And IIRC I also posted a few other fixes for hid2hci tool which didn't
get any response from the crowd.

-- 
Ville Syrjälä
Intel
