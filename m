Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B9BC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD39B20843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfHNHiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:38:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:36839 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHNHiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:38:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 00:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,384,1559545200"; 
   d="scan'208";a="194442150"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2019 00:38:00 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, Sam Ravnborg <sam@ravnborg.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan =?utf-8?Q?Neusch?= =?utf-8?Q?=C3=A4fer?= 
        <j.neuschaefer@gmx.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: Best practice for embedded code samles? [Was: drm/drv: Use // for comments in example code]
In-Reply-To: <20190813160726.3f9eb8c8@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190808163629.14280-1-j.neuschaefer@gmx.net> <20190811213215.GA26468@ravnborg.org> <20190813160726.3f9eb8c8@lwn.net>
Date:   Wed, 14 Aug 2019 10:37:59 +0300
Message-ID: <8736i4gpt4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> On Sun, 11 Aug 2019 23:32:15 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
>
>> I wonder if there is a better way to embed a code sample
>> than reverting to // style comments.
>> 
>> As the kernel do not like // comments we should try to avoid them in
>> examples.
>
> If you're embedding a code sample *into a code comment* then I suspect
> this is about as good as it gets.  The alternative is to put it in as a
> plain literal text block.  That would lose the syntax highlighting; I
> think that's an entirely bearable cost, but others seem to feel
> differently about it.

Not really a Sphinx limitation, is it? You can't embed a /* */ block
comment within a /* */ block comment anyway, Sphinx or not.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
