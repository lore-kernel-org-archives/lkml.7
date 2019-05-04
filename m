Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7521DC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C88C206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 13:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEDNpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 09:45:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:51049 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfEDNpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 09:45:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 May 2019 06:45:22 -0700
X-ExtLoop1: 1
Received: from rajeev-desktop.iind.intel.com (HELO intel.com) ([10.223.25.113])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2019 06:45:19 -0700
Date:   Sat, 4 May 2019 19:15:05 +0530
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "ncrews@chromium.org" <ncrews@chromium.org>,
        "jettrink@chromium.org" <jettrink@chromium.org>,
        "gwendal@google.com" <gwendal@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] platform: chrome: Add ChromeOS EC ISHTP driver
Message-ID: <20190504134504.GA19531@intel.com>
References: <1555496317-16616-1-git-send-email-rushikesh.s.kadam@intel.com>
 <9b4dcd74-5cb4-c7ac-d8be-ed47db35fa87@collabora.com>
 <8d90cf3cdce456e206a54c75c1c35ae5b8c1f6b6.camel@linux.intel.com>
 <nycvar.YFH.7.76.1905021313350.10635@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1905021313350.10635@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri, 

On Thu, May 02, 2019 at 04:44:04PM +0530, Jiri Kosina wrote:
> On Tue, 23 Apr 2019, Srinivas Pandruvada wrote:
> 
> > +Jiri
> > 
> > He is not copied.
> 
> Could you please resubmit the final version, and CC linux-input@ and 
> Benjamin Tissories as appropriate?

I just posted teo linux-input mailing list
https://lkml.org/lkml/2019/5/4/203

Thanks for your help

Rushikesh



> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

-- 
