Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF088C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B64820833
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDNXXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 19:23:21 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:42444 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfDNXXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 19:23:21 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 5CAE75C1578; Mon, 15 Apr 2019 01:22:32 +0200 (CEST)
Date:   Mon, 15 Apr 2019 01:22:32 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: mvebu: add SPDX license identifier
Message-ID: <20190414232232.GA1215@osadl.at>
References: <1555217391-3552-1-git-send-email-hofrat@osadl.org>
 <1555217391-3552-3-git-send-email-hofrat@osadl.org>
 <20190414162210.GC10323@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414162210.GC10323@lunn.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 06:22:10PM +0200, Andrew Lunn wrote:
> On Sun, Apr 14, 2019 at 06:49:51AM +0200, Nicholas Mc Guire wrote:
> > The license is clearly identified as GPL V2 - so just add in the
> > appropriate SPDX license identifier.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> 
> Hi Nicholas
> 
> Adding a SPDX line makes the license text redundant, so you should
> remove it in the same patch as adding the SPDX line.
>
So remove that first line from this paragraph

 * This file is licensed under the terms of the GNU General Public
 * License version 2.  This program is licensed "as is" without any
 * warranty of any kind, whether express or implied.

reducing it to:

 * This program is licensed "as is" without any warranty of any kind,
 * whether express or implied.

Is that what you are proposing ?

The GPL does state that there is no warranty but using a different 
wording that may not be legally equivalent.

thx!
hofrat
