Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D5CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABFB206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfKFGWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:22:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:52917 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfKFGWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:22:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 22:22:14 -0800
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; 
   d="scan'208";a="196098454"
Received: from asantor-mobl.amr.corp.intel.com (HELO localhost) ([10.252.43.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 22:22:12 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Cc:     Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH 3/3] docs: ioctl: Update ioctl-number.rst 'last updated' date
In-Reply-To: <1572969561-17591-4-git-send-email-aleksandar.markovic@rt-rk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1572969561-17591-1-git-send-email-aleksandar.markovic@rt-rk.com> <1572969561-17591-4-git-send-email-aleksandar.markovic@rt-rk.com>
Date:   Wed, 06 Nov 2019 08:22:10 +0200
Message-ID: <87zhh9wmlp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2019, Aleksandar Markovic <aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>
> Update info on the date of the last update of ioctl-number.rst.
>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>  Documentation/ioctl/ioctl-number.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ioctl/ioctl-number.rst b/Documentation/ioctl/ioctl-number.rst
> index 799b90b..f501467 100644
> --- a/Documentation/ioctl/ioctl-number.rst
> +++ b/Documentation/ioctl/ioctl-number.rst
> @@ -2,7 +2,7 @@
>  Ioctl Numbers
>  =============
>  
> -19 October 1999
> +Last update: 5th November, 2019

Pretty sure nobody has cared about the date for about 20 years...

BR,
Jani.

>  
>  Michael Elizabeth Chastain
>  <mec@shout.net>

-- 
Jani Nikula, Intel Open Source Graphics Center
