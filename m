Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8335AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE8C21881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfHHGv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:51:28 -0400
Received: from verein.lst.de ([213.95.11.211]:43709 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730887AbfHHGv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:51:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A7C05227A81; Thu,  8 Aug 2019 08:51:23 +0200 (CEST)
Date:   Thu, 8 Aug 2019 08:51:23 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        'Arnd Bergmann' <arnd@arndb.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'linux-ia64@vger.kernel.org'" <linux-ia64@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: remove sn2, hpsim and ia64 machvecs
Message-ID: <20190808065123.GA29146@lst.de>
References: <20190807133049.20893-1-hch@lst.de> <3908561D78D1C84285E8C5FCA982C28F7F41388B@ORSMSX115.amr.corp.intel.com> <3908561D78D1C84285E8C5FCA982C28F7F4143CB@ORSMSX115.amr.corp.intel.com> <20190807230737.GA11458@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807230737.GA11458@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 04:07:37PM -0700, Luck, Tony wrote:
> On Wed, Aug 07, 2019 at 01:26:17PM -0700, Luck, Tony wrote:
> > Ugh! The rule to do the compression was in arch/ia64/hp/sim/boot/Makefile
> > which went away as part of the deletion of hpsim.
> 
> This fixes it ... should fold into the patch that dropped the
> arch/ia64/hp/sim/boot/Makefile
> 
> I just cut/pasted in those cmd_gzip and cmd_objcopy definitions
> from elsewhere in the tree. It might be possible to simplify them.

Lets keep it simple.  I've picked this up for the hpsim removal patch.
