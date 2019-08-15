Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F64CC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4AC2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GlWiNQ+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfHOWMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:12:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHOWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CS1ls6fq54lREgwpnKLgVGit1qnhnnyNRdGhQ3qigkg=; b=GlWiNQ+LLSaNEkZ0BtXZ+duZ7
        +wAVJ8xYVOA2PT3bcgaKgpvarmXa3aaKlXWhLa17eINI2gLof1x1+CDNfGVXJ8aBbYVxwZDggtDDg
        hFGXiEnjjev2s03n/ij0hZ94oF6WKYjXcHj3xdIsxga4iiSKqQW91gvhVwvL9E4a5KBiBGpRYBKgG
        QO6h69iijBSguBdWVGTFDyRLioWNjiQzKewAsDRnrh1ZW2VMIa6J3Trfs1C10z4KlxlJODYiztaZt
        grtia0YECRIdf2kYntNWkXqlNOFH1pg0v4uHfWxy8hDmTYJDGWy4iI3Y64gDPY52PzRvBLc+egKra
        6z7/JCLqA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyNz3-0006jw-Cr; Thu, 15 Aug 2019 22:12:37 +0000
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20190725130113.GA12932@kroah.com>
 <20190725151302.16a3e0e3@lwn.net> <20190815212019.GB12041@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e3ae0d66-b9eb-97ba-647a-57f3e2eb4af2@infradead.org>
Date:   Thu, 15 Aug 2019 15:12:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815212019.GB12041@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 2:20 PM, Greg Kroah-Hartman wrote:
>>> +The hardware security team will provide a per incident specific encrypted
>> s/per incident specific/incident-specific/
> Fixed.  And changed /a/ to /an/

eh?  still should be /a per incident/

-- 
~Randy
