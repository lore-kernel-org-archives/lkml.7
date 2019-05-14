Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113082147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oudaNEo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfENJyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:54:24 -0400
Received: from mout.web.de ([212.227.17.11]:54589 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENJyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557827504;
        bh=kNnqKhSpD6Lsqqcqj4wkmJSOsBQ6LHHYgZPY+xZL8gw=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=oudaNEo+7A2xt1tG9rQ0AInYBAwPQlCck5cVTK9wjbB021uUK5Ghqh+NlG+cledME
         umUGZYJ/p2l5WYzI1+MyvNioddkhC7Ip8Xd/ukYtS/URj9OADrBFGLcmd2a9EzXE6H
         raFa6SpA/Rjf5enr8UeubzTW2ohbVFSHDuEDTMfc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.122.180]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0yiR-1gYEBj2HEt-00vAoY; Tue, 14
 May 2019 11:51:44 +0200
Subject: Re: [4/5] Coccinelle: put_device: Extend when constraints for twoSmPL
 ellipses
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <201905141718583344787@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wen.yang99@zte.com.cn>
Message-ID: <00dcf0be-78e2-b547-4858-c86eec576607@web.de>
Date:   Tue, 14 May 2019 11:51:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905141718583344787@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:hnuT8/eaYA1y/q3UjqQXWAN+xBCCGwYZRgexsRsrPneIh0jFWhi
 vAFlWOxoSJrDnQjHfVHuAyls0Y3dQoMe5sQeP7NBx+7kWdov65vpllw0IoaxnKMJq6MSNxB
 mrplf2s/eOBdPKSlpNN+YfGO6lQDED+PBA8uRuKYPNnXzCKvIfZLZSlBsce8Cle25KXvhVx
 1/VE5QqdKhiDFFATs8zwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yV6A3OhCQ2s=:bdvrlbby/9qr3HwZB0D7kU
 powwjyIjsd3Je1R1vC47EiXCAZ90wqCXw7l22cKTsyGQNC7R0KnRSArjjo/12YQtaYGUwGi6E
 fEY7bezUlTFWJIwzoHc+BQ5M2frakCFnAizdUsju7g8yilhjR4w3XrQtqBT3v2HrgN99s0P7r
 K+8akjEMkeA/6D2+4TxumbDaiB5zUmpnBj2zQeIqBA2DF9ZMbc8opkrl6rObgNvcUYnv8KZAK
 DpLEmem0maeIA+Xp11BwJ1C2ad7+ErT/+jeOjrj8g1EsyE687KOQY/BNJiEZVyy9sK8WNTu/l
 6fToHNKAi28QkXy8UPo8NEIuWjXg1UYRAeeqtcLZ7Jt/ma7TNiqIrn2ipSXXrC+eryK/HAYwA
 Png1odacYZmYsztPrS7eIjwaCsc6eMFqXOg5YJ+XnOvkExz4fcqv20KRuXDb7W/oBAj4ies04
 ZMIdK7kcHSdxddDyZWsJNNoRnnWJFqPsc0FfwcGVo3h6a5bS+Q125eiKLr++V4RlYS9Vhz4ZB
 ZIV93Fs+6j1JG6GPfnZTN6wG4P5ByA07VGd4DEfQHvW3fhDTz7wEfiSzuwDlmpEQZR5KTp0J/
 nGec8xDNWPlbjVFi4zTrSeFDFktH+gkVujmvQtPrdHjbz2uA9lrOUFDoG8rZNS5wRMF9slPLb
 eFeVS3322EeOyHk8VsQWTUj7ccTzJitrifdE1bcrL1FDCq0//yfA9VdmeiL9HcxZ+Ii9Sgql8
 zvbCGG+JeFyBvxP0pKanNB7PqZYv9dhIiom4OONtpBaAzJgJT7gyrtO1nm+aD90TaRHMnMSIs
 ZppvizB9SeRU7d+Ffb8e9WzYmZ/4mVBwholUAjCuTnj04EYxBqUsan65XjQkYhJo9GiYecTsR
 VGXjO94MRqwxoUBKtvzryileF2kzXtHlQbD6NfaHkmpyzV9/z1qLKgY40hyXdpG4aPicdyecE
 qXjGg+yg2HQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I did another experiment at that time and found that this modification will
> reduce the false positive rate,

Thanks for such feedback.

Will my update suggestion influence the current (or future) software situation?


> but it may also reduce the recall rate.

Would you like to explain this information a bit more?


> Could we use it to find out as many bugs as possible in the current kernel
> and then modify it?

I hope so.

* Will the false positive rate influence change acceptance considerably?

* Would you like to work with source code analysis approaches based on
  adjusted confidence settings?

Regards,
Markus
