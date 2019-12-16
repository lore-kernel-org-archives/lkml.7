Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66512C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE33206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfLPNPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:15:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:54696 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfLPNPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:15:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 05:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,321,1571727600"; 
   d="scan'208";a="209298033"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 16 Dec 2019 05:15:30 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 16 Dec 2019 15:15:29 +0200
Date:   Mon, 16 Dec 2019 15:15:29 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display/ingenic: Add compatible
 string for JZ4770
Message-ID: <20191216131529.GN1208@intel.com>
References: <20191210144142.33143-1-paul@crapouillou.net>
 <20191214105418.GA5687@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191214105418.GA5687@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 11:54:18AM +0100, Sam Ravnborg wrote:
> Hi Paul.
> 
> On Tue, Dec 10, 2019 at 03:41:37PM +0100, Paul Cercueil wrote:
> > Add a compatible string for the LCD controller found in the JZ4770 SoC.
> > 
> > v2: No change
> > 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Whole series looks good.
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Paul, looks like you forgot to git commit --amend after adding the tags.
Now the commit messages have and extra "# *** extracted tags ***" in them.

-- 
Ville Syrjälä
Intel
