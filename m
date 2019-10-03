Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B394C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E3A20679
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfJCPJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:09:59 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:56052 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbfJCPJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:09:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6981318225E03;
        Thu,  3 Oct 2019 15:09:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: move54_39a3222fc933b
X-Filterd-Recvd-Size: 1870
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Oct 2019 15:09:55 +0000 (UTC)
Message-ID: <de5e7cd39ce661f8441fb4f5bdf21ee37ada1366.camel@perches.com>
Subject: Re: [PATCH 3.16 29/87] staging: iio: cdc: Don't put an else right
 after a return
From:   Joe Perches <joe@perches.com>
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Catalina Mocanu <catalina.mocanu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <3fe1cd65a7860464d3780b57c734d12880df4b92.camel@decadent.org.uk>
References: <lsq.1570043211.136218297@decadent.org.uk>
         <6436567dd141e5528a5363dd3aaad21815a1c111.camel@perches.com>
         <3fe1cd65a7860464d3780b57c734d12880df4b92.camel@decadent.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Thu, 03 Oct 2019 08:09:05 -0700
User-Agent: Evolution 3.32.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-03 at 15:47 +0100, Ben Hutchings wrote:
> On Wed, 2019-10-02 at 14:36 -0700, Joe Perches wrote:
> > On Wed, 2019-10-02 at 20:06 +0100, Ben Hutchings wrote:
> > > 3.16.75-rc1 review patch.  If anyone has any objections, please let me know.
> > 
> > This doesn't look necessary.
> 
> It allows the next patch to apply cleanly.

Perhaps when you pick patches that are unnecessary
for any other reason but to allow easier picking of
actual fixes, the nominal unnecessary patches could
be marked as necessary for follow-on patches.

Also, when you send these patch series, please use
an email delay of at least 1 second between each
entry in the series as the threading is otherwise
poor in various email clients when sorting by time.


