Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB2BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A924207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfCYXiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:38:22 -0400
Received: from smtprelay0140.hostedemail.com ([216.40.44.140]:39692 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbfCYXiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:38:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B9CB6837F24C;
        Mon, 25 Mar 2019 23:38:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wish00_e884140d0c40
X-Filterd-Recvd-Size: 1699
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 23:38:19 +0000 (UTC)
Message-ID: <87e98473d586e2549f49829e62738cd8738ec873.camel@perches.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'IBM Power Virtual
 Accelerator Switchboard'
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Mon, 25 Mar 2019 16:38:18 -0700
In-Reply-To: <20190325233521.31094-1-joe@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
         <20190325233521.31094-1-joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 16:35 -0700, Joe Perches wrote:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
> 
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.
> 
> The commits that added and if found renamed or removed the file pattern
> are shown below.
> 
> Please fix this defect appropriately.
> 
> 1: ---------------------------------------------------------------------------
> 
> linux-next MAINTAINERS section:
> 
> 	7396	IBM Power Virtual Accelerator Switchboard
> 	7397	M:	Sukadev Bhattiprolu

btw: Your name needs an email address here too.

This should be:

M:	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>


