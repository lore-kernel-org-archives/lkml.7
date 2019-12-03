Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D325C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153382073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="NZgDZvai";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="NZgDZvai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLCOeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:34:14 -0500
Received: from node.akkea.ca ([192.155.83.177]:55906 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCOeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:34:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 7A4D94E200E;
        Tue,  3 Dec 2019 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575383653; bh=9EZCdQydtdvIE92/1ypyPqXdksi6OLhJTwPHjark2o0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=NZgDZvaiITTRZLJm2hjTVrCkq4j07CdwftQQbzBYnVAXprfU/9TW/LjA6MMacJlWd
         PPBL+EZnswgGUZEsPVg0YE0tqz2On/Tt3coap5qPzZ7ShrW4hQewVW02Pnvq99uEt8
         AgwTldO/UJIXcQOvnCIQ0Qw7ghGGZp/FpIsApZMc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zHo31eXuCngz; Tue,  3 Dec 2019 14:34:13 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 152094E2003;
        Tue,  3 Dec 2019 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575383653; bh=9EZCdQydtdvIE92/1ypyPqXdksi6OLhJTwPHjark2o0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=NZgDZvaiITTRZLJm2hjTVrCkq4j07CdwftQQbzBYnVAXprfU/9TW/LjA6MMacJlWd
         PPBL+EZnswgGUZEsPVg0YE0tqz2On/Tt3coap5qPzZ7ShrW4hQewVW02Pnvq99uEt8
         AgwTldO/UJIXcQOvnCIQ0Qw7ghGGZp/FpIsApZMc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Dec 2019 07:34:13 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add the broadmobi BM818
In-Reply-To: <20191203142759.GJ1998@sirena.org.uk>
References: <20191202174831.13638-1-angus@akkea.ca>
 <20191203142759.GJ1998@sirena.org.uk>
Message-ID: <49c981e5419bbcedd271216350b4e777@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2019-12-03 07:27, Mark Brown wrote:
> On Mon, Dec 02, 2019 at 10:48:29AM -0700, Angus Ainslie (Purism) wrote:
> 
>>   sound: codecs: gtm601: add Broadmobi bm818 sound profile
>>   ASoC: gtm601: add the broadmobi interface
> 
> These subject styles don't even agree with each other :( - please
> try to be consistent with the style for the subsystem (the latter
> one matches, the first one doesn't).
> 

Ok I'll fix that. I pulled those out of previous commit messages of 
those files.

> Please also try to think about your CC lists when sending
> patches, try to understand why everyone you're sending them to is
> getting a copy - kernel maintainers get a lot of mail and sending
> not obviously relevant patches to random people adds to that.

I used the output of ./scripts/get_maintainer.pl . Is that not the 
correct way to generate the CC list ?

Thanks
Angus
