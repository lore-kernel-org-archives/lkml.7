Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDECB21902
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDHJR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:17:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:13399 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDHJRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:17:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 02:17:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="129503783"
Received: from troebing-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.249.45.170])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2019 02:17:19 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 3072221E50; Mon,  8 Apr 2019 12:17:10 +0300 (EEST)
Date:   Mon, 8 Apr 2019 12:17:09 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mickael GUENE <mickael.guene@st.com>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        Jason Chen <jasonx.z.chen@intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Alan Chiang <alanx.chiang@intel.com>
Subject: Re: [PATCH v4 2/2] media:st-mipid02: MIPID02 CSI-2 to PARALLEL
 bridge driver
Message-ID: <20190408091709.z27wmi47reu6zmuu@kekkonen.localdomain>
References: <1552373045-134493-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-1-git-send-email-mickael.guene@st.com>
 <1553680545-73278-3-git-send-email-mickael.guene@st.com>
 <20190406105606.rciacao5d4hljbbu@kekkonen.localdomain>
 <4feccc4c-5873-5854-c1b8-6a32d6fc473f@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4feccc4c-5873-5854-c1b8-6a32d6fc473f@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mickael,

On Mon, Apr 08, 2019 at 08:20:09AM +0000, Mickael GUENE wrote:
...
> > The above are just minor improvements and cleanups. If you're fine with the
> > proposed change to the first patch, I can merge this version of the patches
> > and you could submit changes to the above in a separate patch.
> > 
> Thanks for the proposal, but I prefer to to a full v5 if you agree ?

That is fine, too.

> I will also add MEDIA_BUS_FMT_BGR888_3X8 or MEDIA_BUS_FMT_BGR888_3X8_BE
> support.

Ack. Please add a separate patch for that.

I guess postfix isn't needed as changing the endianness just changes the
pixel order in this case.

> >> +	.remove   = mipid02_remove,
> >> +};
> >> +
> >> +module_i2c_driver(mipid02_i2c_driver);
> >> +
> >> +MODULE_AUTHOR("Mickael Guene <mickael.guene@st.com>");
> >> +MODULE_DESCRIPTION("STMicroelectronics MIPID02 CSI-2 bridge driver");
> >> +MODULE_LICENSE("GPL v2");

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
