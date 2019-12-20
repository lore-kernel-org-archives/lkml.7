Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F31C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5303F2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="b9RQp2P6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLTQXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:23:33 -0500
Received: from mout.web.de ([212.227.17.11]:56171 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfLTQXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576859008;
        bh=P4G4oYdUoX5+egBlE8qx9wDDi126Ebu9ZkrOyVj4uqk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=b9RQp2P6oYhWDmlOGac9j8WKrzV/KlY+YXYQUEg4jfhOx/3q5/1UpA43veuaXwfi3
         2yghlDALmeqxAKCLDpC93RMe61x2+j0qllZQc0qoClkEC3qkqQeZklJwTKe9zX00nn
         vv9Veh7yhRkcd0kbcBeFNKXu7IGu/O/Yh/IgID8k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.94.196]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lj2I6-1i6G9m0qBK-00dHhq; Fri, 20
 Dec 2019 17:23:28 +0100
Subject: Re: Improving documentation for programming interfaces
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <350cd156-9080-24fe-c49e-96e758d3ca45@web.de>
 <20191220151945.GD59959@mit.edu>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0557f349-322c-92b3-9fc3-94e59538ca91@web.de>
Date:   Fri, 20 Dec 2019 17:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220151945.GD59959@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5HL4Y753b/ojoHobkw9U2XXAOUaiy2Qj7B3N0w/LllHc6t1hzK5
 TIDc9b33CxZbnJmbl5EKU47GGRyFVVRBx8qOOOGyxznuQzub8SGvyn2VikYZPKDJpfoHicc
 +49UbIWo/lL29rLB16ZAQlFXOEfJcJm/DA2saOQdHHrg3v9cZW3VqX4yu18QORm2lP+Yjl4
 /6ZNj+vr9Ifh8WmMutvXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oMShP+K63/A=:MY2aXl1l5HcRhOfzMbLwLs
 /0Ueaw+ivhGUymlXjkae9wBGHe/Sg1lv74iu5rT32fx3B/wTMBUDG8bgeaTgstSsRxehUD1iw
 wmzmy5H8RbOu3JNv5Gl6yzZqfXEaJbohC4lt3ICe9aRdvshQOuzSokj0Kvr+GQRt+ZUYcKoKy
 0hE9Uhn68u6W7bpiujXPAC/bYm+zu5lnW9px1EQbFy0R4bZVUNvlaW9ZQkO86mCA0vBVTmtE7
 I4e5qF3bnlf7TmaTST1bCFl1bfrjaTRsJ5AYHrdKVzJKvXpGeCpRBDqqkxcXJGmmTx/0mHtVt
 O8wboVXyJ5t2DieAY9fDBv1iSJ4lHeQFBe1mfwrJQLPGh+aEmFI0U5t82zJ42xBjD5pSOti1V
 gI22WE+wrUdKkDdAFKdz2rK76P3VZuIoIzZCxKM+KPcNWEn7Gt1GpSKQoYI+jwegn5Dz5jbj+
 ezlCNp81zml4dzuPhEQvhPM1vGxyEvv3ftQot6Y8kp6fF4oAgcqpvHCE95KQFehH23yiHZpKP
 A8VoCoNpSQIoYPeq4BGGDOnVuAq0yAg5O/Tpdelwj27o6XIzIF+am1NTNrdGNUCMs6LFai6ZV
 Jeprb1G9cnM/NZGJQhThRbuMp5P0TP7OSJ1qoLD40wko9tzGOpudMd6HLYLGz49SYrqsjgada
 sFN7LanP1gBDk9wEymSEl3MuohBNG3CMVQcX3gV0IPXduxJPt6wnRCIukSkTcZ06D3HzBnm12
 rNd5AA1wtzZrofM+XSfstBqhmAXuuwFvAf5j1PWQtimVaCcHN4lvhm/v6lik7KVkjdifLqot5
 Au8L7IzTZYRf4ItSKdrdA9E0btmu5T5HbaL0RuCMZ1s00AcwZ9pfhCLlp1Wu2j1uhJo26tDuZ
 02Vn+a1SYPHz9YnEF2TVgV52i00liHPTyuMOy57ZyH29QH3P16soCTRrtgFoPxZCYl6TnA0Vp
 hrQhyJajcUe0kUBcmGJyyyWe8C2c90Dg3tjslFESBOtbO8w6/Gdm5fiQGsA4mOBl8yARaZ+zk
 utJH4SFUxGFWHlyhi2q9mc87KAtlXWu/nE0PSNiHCMS0pr58aL+6jmodenEcoVDD+CYWo61L0
 T2RY7DCiotjRwm0l3rp3KzjDh+xjynKEB31ZMPFuHLl2v+bWbqO6WcGoMl7n7edb9DpEezFXl
 KGd/2B7zljSlQdrrI/xBRjmDFgN5/IHLwZ5UwYGZm6gW6mP1OLOrphczxr2XCebfwE8W4e4RP
 UgNMICEUHxXRBu7Ips78mAEl1XUhBl9PFw+4tYaAFU+USj209BNJz4FXbuYU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Some functions allocate resources to which a pointer (or handle) is ret=
urned.
>> I would find it nice then if such a pointer would contain also the back=
ground
>> information by which functions the resource should usually be released.
>>
>> Can it become easier to determine such data?
=E2=80=A6
> It's unclear to me what you are requesting/proposing?

I suggest to clarify combinations for object construction and proper resou=
rce release.


> Can you be a bit more concrete?

Further examples:
* kmalloc =E2=87=92 kfree
* kobject_create =E2=87=92 kobject_put
* device_register =E2=87=92 put_device

Can preprocessor macros help to express any more relationships for similar=
 function pairs?

Regards,
Markus
