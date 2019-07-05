Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5260CC4649C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29445218BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfGELO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:14:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727760AbfGELO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:14:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0435308402F;
        Fri,  5 Jul 2019 11:14:27 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF2B617509;
        Fri,  5 Jul 2019 11:14:27 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 68A7F18184AC;
        Fri,  5 Jul 2019 11:14:26 +0000 (UTC)
Date:   Fri, 5 Jul 2019 07:14:26 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jakub Staron <jstaron@google.com>,
        Cornelia Huck <cohuck@redhat.com>
Message-ID: <631342573.39265254.1562325266039.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190705210950.6b77ec77@canb.auug.org.au>
References: <20190705172025.46abf71e@canb.auug.org.au> <616554090.39241752.1562316343431.JavaMail.zimbra@redhat.com> <20190705210950.6b77ec77@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the nvdimm tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.94, 10.4.195.14]
Thread-Topic: linux-next: build failure after merge of the nvdimm tree
Thread-Index: f+SU09VqGmarpUONhbtt5EFHpdMF4A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 05 Jul 2019 11:14:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Hi Pankaj,
> 
> On Fri, 5 Jul 2019 04:45:43 -0400 (EDT) Pankaj Gupta <pagupta@redhat.com>
> wrote:
> >
> > Thank you for the report.
> 
> That's what I am here for :-)

:-)

> 
> > Can we apply below patch [1] on top to complete linux-next build for today.
> > I have tested this locally.
> 
> Its a bit of a pain to go back and linux-next is done for today (after
> 13 hours :-)).  You really should do a proper fix patch and get it
> added to the nvdimm tree.

Sure, Thank you! Stephen.

Best regards,
Pankaj

> 
> --
> Cheers,
> Stephen Rothwell
> 
