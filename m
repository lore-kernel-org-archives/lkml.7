Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0559FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F8D218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfCTVS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:18:26 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:45476 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727476AbfCTVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:18:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 68E0718224BBD;
        Wed, 20 Mar 2019 21:18:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cast68_66527923e313a
X-Filterd-Recvd-Size: 2022
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Mar 2019 21:18:23 +0000 (UTC)
Message-ID: <52138d9db7b1765133f21fe08b0f3ad37da9d799.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix camel case seeding when run with --root
From:   Joe Perches <joe@perches.com>
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        Joe Perches <golf@perches.com>
Cc:     Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Date:   Wed, 20 Mar 2019 14:18:21 -0700
In-Reply-To: <02874ECE860811409154E81DA85FBB589232E64D@ORSMSX121.amr.corp.intel.com>
References: <20190315010334.5707-1-jacob.e.keller@intel.com>
         <02874ECE860811409154E81DA85FBB589232E64D@ORSMSX121.amr.corp.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 20:09 +0000, Keller, Jacob E wrote:
> > -----Original Message-----
> > From: Keller, Jacob E
> > Sent: Thursday, March 14, 2019 6:04 PM
> > To: linux-kernel@vger.kernel.org
> > Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; netdev@vger.kernel.org;
> > Keller, Jacob E <jacob.e.keller@intel.com>; joe@perches.com
> > Subject: [PATCH] checkpatch: fix camel case seeding when run with --root
> > 
> > checkpatch.pl avoids warning about camel case of some definitions by
> > seeding a file that tracks all of the currently committed camel case
> > definitions.
> > 
> > To build this seed file, checkpatch.pl decides between using git or the
> > --root parameter.
> > 
> > This works as long as you don't run checkpatch.pl from within
> > a different git tree that is not the Linux kernel.

Odd use case, but I'll forward it on as it doesn't
seem to have any other effect.

cheers, Joe

