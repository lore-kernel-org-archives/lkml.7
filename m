Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A90ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E65206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfJIKKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:10:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:33244 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfJIKKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:10:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 03:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="206849744"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 09 Oct 2019 03:10:49 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 09 Oct 2019 13:10:49 +0300
Date:   Wed, 9 Oct 2019 13:10:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Christian Kellner <ckellner@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH] thunderbolt: Add 'generation' attribute for devices
Message-ID: <20191009101048.GO2819@lahna.fi.intel.com>
References: <20191003173242.80938-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003173242.80938-1-ckellner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 07:32:40PM +0200, Christian Kellner wrote:
> From: Christian Kellner <christian@kellner.me>
> 
> The Thunderbolt standard went through several major iterations, here
> called generation. USB4, which will be based on Thunderbolt, will be
> generation 4. Let userspace know the generation of the controller in
> the devices in order to distinguish between Thunderbolt and USB4, so
> it can be shown in various user interfaces.
> 
> Signed-off-by: Christian Kellner <christian@kellner.me>
> ---
>  Documentation/ABI/testing/sysfs-bus-thunderbolt |  8 ++++++++
>  drivers/thunderbolt/switch.c                    | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> index b21fba14689b..630e51344f1c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> @@ -80,6 +80,14 @@ Contact:	thunderbolt-software@lists.01.org
>  Description:	This attribute contains 1 if Thunderbolt device was already
>  		authorized on boot and 0 otherwise.
>  
> +What: /sys/bus/thunderbolt/devices/.../generation
> +Date:		Aug 2019

I updated this to be Jan 2020, which is estimated release date of v5.5
according to http://phb-crystal-ball.org/, and queued it for v5.5.

Thanks!
