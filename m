Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5AFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CFC20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6Iw/XAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDLTKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:10:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47071 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDLTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:10:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so9797957ljk.13;
        Fri, 12 Apr 2019 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lwKy9jnTAZ6DQi3dgZijiDLurpRLzjl8Zo7wbipVUBk=;
        b=r6Iw/XAo8gxVxsxsvAxm+thqW/cr6vDtnLx59yblwMpX0NM9ORBTeG+RabiAcdQn92
         reyACNOYsbm4lctpnRr9RFPId1l6AB2RFitjWbrev0ScfWpdgnM+xy8+mi/04qzIuX4F
         XLIts0Kx01nroW/lMa1o1IwZA3+qPAOdHr84EnvaAjxjVu9kR2CnYsZ+7MPI3ZBGEMYy
         t0R4aYqEG+jqXwLSfvycFyPTVyJ1rwap0vwGtwgAgqLnBBz0yCRT1v+kzZjz+0IzVqZp
         N+MbT3qlcu083gFOTWsdrY5ON/uJVou8Lq3rG/WaSmlHVC98LI5FmuK1IlHlyoVcjgE3
         Zpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lwKy9jnTAZ6DQi3dgZijiDLurpRLzjl8Zo7wbipVUBk=;
        b=jZsbz9ah/QzaYKNlLLOsVYa957qQn38EcKGjtC+JGOv7LoQYQv8Kk5cdNglh3zNlIL
         QN9MAa2o86FKHHVFUjIHF659EdesLYK6EZrkLKHOgz4lHAMxbYWXCpANRBnJ85amuWP5
         +RrJn24F6P8PzZvABI73YsqM7xOSkYaaXCDEhznmi4Uz0NDEhkgQ+IFgfGxt9dbILJVi
         XViH+Dv89StbK1Ei+S0rDCwoju+/DZh8cuaKDF4Eu/Kzj6T3kn+6mXNZEQi31orJTeps
         +LurKsrUw1TC6uZRyrwdwJnDtGdy9cL6F6P39IrkZ3HKRg6JSc6LhkcDL1JcNWyVLZvI
         Re5w==
X-Gm-Message-State: APjAAAVgJ4Ti/RjyzDqYFJ4xCnXP9oCF7Gay2gI/7X3MaeTzOXpt2zlt
        jIzAheAc3KX248B8Idfdhj/lvurJ
X-Google-Smtp-Source: APXvYqzjTK8zw5HpggyVhQZXqzk0c9WCYgB9idAu2ujlubLb9U1lmPDetjnq5svbpgltfdOX0Dpqkg==
X-Received: by 2002:a2e:5c7:: with SMTP id 190mr30839870ljf.108.1555096252359;
        Fri, 12 Apr 2019 12:10:52 -0700 (PDT)
Received: from [192.168.1.19] (chg144.neoplus.adsl.tpnet.pl. [83.31.4.144])
        by smtp.gmail.com with ESMTPSA id u17sm9001014lfu.63.2019.04.12.12.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 12:10:51 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings
 documention
To:     Dan Murphy <dmurphy@ti.com>, Marek Behun <marek.behun@nic.cz>
Cc:     robh+dt@kernel.org, pavel@ucw.cz, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-3-dmurphy@ti.com> <20190412000707.70f8319f@nic.cz>
 <5675ac20-6db2-34ea-938a-01f0076b87e7@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <7a987453-0e4d-be27-790e-efa4a0f40b2b@gmail.com>
Date:   Fri, 12 Apr 2019 21:10:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5675ac20-6db2-34ea-938a-01f0076b87e7@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 4/12/19 1:50 PM, Dan Murphy wrote:
> Marek
> 
> On 4/11/19 5:07 PM, Marek Behun wrote:
>> Hi Dan,
>> this probaly was discussed, but I did not follow brightness model
>> discussions:
>> what will happen if I set yellow by writing into yellow mode
>> brightness, and then orange by writing orange model brightness?
>> Will the resulting color be a mix of yellow and orange, or will the
>> orange overwrite the yellow setting?
>>
> 
> This was not discussed and is a good question.  If you write the yellow mode for a group of
> LEDs then yellow would be produced for the brightness requested.
> 
> If orange is then requested then orange should be displayed at the brightness level requested.
> So yes the orange will over write the yellow.

Yes, and individual color brightness levels should correspond
to the color components of the brightness-model level currently set.

> The next question is if the absolute colors are written does it produce the same behavior?
> 
> So if you have yellow and write to the red should the red LED brightness be modified or should the
> color switch to red?
> And if the red LED is on and the blue LED is written should the color switch to blue or should the blue and red LEDs be mixed together?

Now, if any of the color brightness files is altered it should update
the hardware with this new setting, but brightness-model and main
brightness level should not be changed. The thing that is missing in our
proposal is lack of the way to check if brightness-model is up to date
(i.e. if it reflects what is written to the hardware).

How about utilizing the sync file from the new colors directory?
It could return 1 on read when brightness levels of all colors
match exactly the ones assigned to the brightness model level currently
set.

> This is tricky as the user space can write the individual absolute colors and mix the LEDs to produce varying
> colors.  But the behavior writing the brightness models are different.
> 
> I would almost prefer that the user space reads the available absolute LED colors and creates the devices supported color palette and write the absolute LED colors only.  But this violates the requirements asked for.
> 
> Dan
> 
>> Marek
>>
> 

-- 
Best regards,
Jacek Anaszewski
