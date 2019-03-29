Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679EB20693
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfC2JmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:42:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:40833 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfC2JmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:42:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 02:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="218706867"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.156])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2019 02:42:12 -0700
Date:   Fri, 29 Mar 2019 11:42:12 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] 5.1-rc1: tpm_try_transmit: send(): error -5
Message-ID: <20190329094212.GC21379@linux.intel.com>
References: <20190327082115.k35fhxfkk25ekdzw@dumbo>
 <20190328122333.GA7094@linux.intel.com>
 <20190328172141.sog6prtldmxulpw7@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328172141.sog6prtldmxulpw7@dumbo>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:21:41PM +0100, Domenico Andreoli wrote:
> On Thu, Mar 28, 2019 at 02:23:33PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 27, 2019 at 09:21:15AM +0100, Domenico Andreoli wrote:
> > > Hi Jarkko,
> > > 
> > >   my laptop fails to suspend/hibernate since v5.1-rc1, it worked fine
> > > with v4.20 and previous.
> > > 
> > > My suspect is on tpm_tis driver, is there anything I can do to understand
> > > what goes wrong here?
> > > 
> > > Best regards,
> > > Domenico
> > 
> > Thank you for reporting this.
> > 
> > Can you try if this helps:
> > 
> > https://patchwork.kernel.org/patch/10865495/
> 
> Yes, it helps. Everything works fine now. Thanks.

Perfect, thank you.

/Jarkko
