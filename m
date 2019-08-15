Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06688C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F9D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CAQ+IYG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbfHOXKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:10:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbfHOXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TRvle+ToJwUGZSz2o4z4HL+lfRoAh8b5g7ahx3uFjrg=; b=CAQ+IYG8uWK4/XIclus7nyqqa
        tVflJ5MMvlEWzvMMV6WUVhYTPA8qxNQledcXDm+ibNlL2B5ax6fwXExGN9dbGkmzO4pbBNUO7R00I
        RJbmhCrvAhaZQjEogU+PrQZDnr8+NBcNCE94Mpjzi9msYYZW4CLsrOqZhvLmRGQtQ7+wE4CwB7xVc
        2k99njFYAJP6/f1IDA0yUggro+gx66orfDTu6RVoF3Oe9dGgZ5pHTZ5s+WGMgtNo54EDIxvl6/t34
        Pa0K5+JPK57a8JakNW3/59Xqpy0/40JXCcidnb6ofsghECha/P+lWxMGWgQqOdGFQ/dMQAwd3v68w
        NUO/0MjSQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyOtG-0002Ec-Q0; Thu, 15 Aug 2019 23:10:42 +0000
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20190725130113.GA12932@kroah.com>
 <20190725151302.16a3e0e3@lwn.net> <20190815212019.GB12041@kroah.com>
 <e3ae0d66-b9eb-97ba-647a-57f3e2eb4af2@infradead.org>
 <20190815223147.GA28275@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0d8ee183-7559-99ee-8c83-a902e7215da8@infradead.org>
Date:   Thu, 15 Aug 2019 16:10:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815223147.GA28275@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 3:31 PM, Greg Kroah-Hartman wrote:
> On Thu, Aug 15, 2019 at 03:12:34PM -0700, Randy Dunlap wrote:
>> On 8/15/19 2:20 PM, Greg Kroah-Hartman wrote:
>>>>> +The hardware security team will provide a per incident specific encrypted
>>>> s/per incident specific/incident-specific/
>>> Fixed.  And changed /a/ to /an/
>>
>> eh?  still should be /a per incident/
> 
> The sentence was changed to:
> 	The hardware security team will provide an incident-specific
> 	encrypted...
> 
> is not "an" correct here?

That's good then.  I didn't see the complete sentence.

-- 
~Randy
