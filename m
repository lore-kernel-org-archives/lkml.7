Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E909C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150752084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfHONeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:34:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:16788 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbfHONeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:34:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 06:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="194766618"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 15 Aug 2019 06:33:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 15 Aug 2019 16:33:58 +0300
Date:   Thu, 15 Aug 2019 16:33:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] software node: Add software_node_find_by_name()
Message-ID: <20190815133358.GC24772@kuha.fi.intel.com>
References: <20190815112826.81785-1-heikki.krogerus@linux.intel.com>
 <20190815112826.81785-2-heikki.krogerus@linux.intel.com>
 <CAHp75VduJ2VQ-4r-vrARMyL6WAnsppwMtLRD-g4f-GEnew8m2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VduJ2VQ-4r-vrARMyL6WAnsppwMtLRD-g4f-GEnew8m2g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 03:55:40PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 15, 2019 at 2:32 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Function that searches software nodes by node name.
> 
> > +/**
> > + * software_node_find_by_name - Find software node by name
> > + * @parent: Parent of the software node
> > + * @name: Name of the software node
> > + *
> > + * The function will find a node that is child of @parent and that is named
> > + * @name. If no node is found, the function returns NULL.
> 
> Shouldn't we add that the caller responsible of putting kobject?

OK. I'll fix this and the other one too.

Thanks Andy!

-- 
heikki
