Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B41A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfCYQzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:55:41 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:43128 "EHLO
        20.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:55:40 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 12:55:39 EDT
Received: from player739.ha.ovh.net (unknown [10.109.159.222])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id BF81A1BA06D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:49:27 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player739.ha.ovh.net (Postfix) with ESMTPSA id 0B61B42A849F;
        Mon, 25 Mar 2019 16:49:19 +0000 (UTC)
Date:   Mon, 25 Mar 2019 17:49:19 +0100
From:   Greg Kurz <groug@kaod.org>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 0/4] ocxl: OpenCAPI Cleanup
Message-ID: <20190325174919.5c877cf9@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190325053456.14599-1-alastair@au1.ibm.com>
References: <20190320053448.2098-1-alastair@au1.ibm.com>
        <20190325053456.14599-1-alastair@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 474848285720549707
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrjeekgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alastair,

I forgot to mention it during v3 but please don't link new version
of a patchset to the previous one with --in-reply-to. This is to
ensure I can see them in my email client without having to scroll
back many days in the past (which likely means a fair number of
e-mails on linuxppc-dev).

Cheers,

--
Greg

On Mon, 25 Mar 2019 16:34:51 +1100
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some minor cleanups for the OpenCAPI driver as a prerequisite
> for an ocxl driver refactoring to allow the driver core to
> be utilised by external drivers.
> 
> Changelog:
> V4:
>   - Drop printf format changes as they omit the format indicator for '0'
> V3:
>   - Add missed header in 'ocxl: Remove some unused exported symbols'.
>     This addresses the introduced sparse warnings
> V2:
>   - remove intermediate assignment of 'link' var in
>                 'Rename struct link to ocxl_link'
>   - Don't shift definition of ocxl_context_attach in
>                 'Remove some unused exported symbols'
> 
> 
> Alastair D'Silva (4):
>   ocxl: Rename struct link to ocxl_link
>   ocxl: read_pasid never returns an error, so make it void
>   ocxl: Remove superfluous 'extern' from headers
>   ocxl: Remove some unused exported symbols
> 
>  drivers/misc/ocxl/config.c        | 13 ++---
>  drivers/misc/ocxl/file.c          |  5 +-
>  drivers/misc/ocxl/link.c          | 36 ++++++-------
>  drivers/misc/ocxl/ocxl_internal.h | 85 +++++++++++++++++++------------
>  include/misc/ocxl.h               | 53 ++++++-------------
>  5 files changed, 91 insertions(+), 101 deletions(-)
> 

