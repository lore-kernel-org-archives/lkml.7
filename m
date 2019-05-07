Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E45BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E876520578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="j2B8NPcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfEGLmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:42:33 -0400
Received: from node.akkea.ca ([192.155.83.177]:49682 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfEGLmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:42:33 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id BEBD64E204B; Tue,  7 May 2019 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557229352; bh=C0T2IpdRD2/K4cMjYfhgSOlqn0r5UpwBR7WvL8IiUxg=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=j2B8NPcCR3ORPAgBvJcTecqX0UPlq2iT20JQafpPzEe75dx+wfNMBnhdCp0BQ1Dak
         Urr86UQP9JVCzZhCKYCBuFVGkKLmCnp0slkj5E3jYm0M03vcijnquo6p1hTnVwYqjG
         PK/7pOsoGEeAkoCPz3ppKSpwUXbnOZIlScuoo5/g=
To:     Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] usb: typec: tcpm: Clear the fault status register
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 May 2019 05:42:32 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Fabio Estevam <festevam@gmail.com>, angus.ainslie@puri.sm,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck7@gmail.com>
In-Reply-To: <20190506152736.GA29049@roeck-us.net>
References: <20190506140830.25376-1-angus@akkea.ca>
 <20190506140830.25376-4-angus@akkea.ca>
 <CAOMZO5C6XQUWBi39jKeVJg3Jj6auB0mF3h8bWMYZ_prXwgc9Fg@mail.gmail.com>
 <20190506152736.GA29049@roeck-us.net>
Message-ID: <c0345959db38ad5ba1c8f370c31c63cb@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-06 09:27, Guenter Roeck wrote:
> On Mon, May 06, 2019 at 12:11:41PM -0300, Fabio Estevam wrote:
>> Hi Angus,
>> 
>> On Mon, May 6, 2019 at 11:10 AM Angus Ainslie (Purism) 
>> <angus@akkea.ca> wrote:
>> >
>> > If the fault status register doesn't get cleared then
>> > the ptn5110 interrupt gets stuck on. As the fault register gets
>> > set everytime the ptn5110 powers on the interrupt is always stuck.
>> >
>> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> 
>> Since this is a bug fix, I would suggest adding a Fixes tag and Cc
>> stable if appropriate.
>> 
>> I would also put this patch as the first one in the series, so that it
>> can be easily applied to older stable trees.
> 
> Unfortunately there is an added tcpm_log() ... and I am opposed to 
> exporting
> that.
> 

Ok I'll fix them both up for v2.

> Guenter

