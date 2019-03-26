Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6127B2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LATDvmGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfCZMnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:43:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gL3df5L1HoTWFH8unFKryxhSs/juRPBxhxE3ZuJLMGg=; b=LATDvmGnuyPrgONBtmPBf77AC
        KAiQiUDmtULDnYX27Ef1yBNmlwBlt+pHRtChYWDMGbWanqgcoGh/xVZNDCDstxxer3u2iP6mqTBtm
        RNcKy7CPSfbiXTaQOUqTOiqZmiuRJJAXyMVekY4PUjabohT6Vzfcz9IzH0nxzbJN3iHiD08Fw20Sn
        xIbHT0RH4qyt348aOHjFbhMIpXHLa2BlXxYibvoM5V1X5w8w3S3mL6gtCxNqv5/QamV7yBQxOmdCS
        VeicIeNCfHDvzSgGyYMEGvpdqe2fJPqdKW/PsK/3bSJ4nomuK3GDfmZQ2YXVlrysJj6ebLZyMDjz5
        zaCyTcHXw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8lQ0-0001ki-Us; Tue, 26 Mar 2019 12:43:04 +0000
Date:   Tue, 26 Mar 2019 05:43:04 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [External] Re: Print map for total physical and virtual memory
Message-ID: <20190326124304.GN10344@bombadil.infradead.org>
References: <SG2PR02MB3098F980E1EB299853AC46E6E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190326113657.GL10344@bombadil.infradead.org>
 <SG2PR02MB3098B0C0CD27969FB7C9ECD7E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR02MB3098B0C0CD27969FB7C9ECD7E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:35:25PM +0000, Pankaj Suryawanshi wrote:
> From: Matthew Wilcox <willy@infradead.org>
> Sent: 26 March 2019 17:06
> To: Pankaj Suryawanshi
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
> Subject: [External] Re: Print map for total physical and virtual memory
> 
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.

... you should probably use gmail or something.  Whatever broken email
system your employer provides makes it really hard for you to participate
in any meaningful way.

> Can you please elaborate about tools/vm/page-types.c ?

cd tools/vm/
make
sudo ./page-types

If that doesn't do exactly what you need, you can use the source code to
make a program which does.
