Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E780C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0086E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfDVTy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:54:57 -0400
Received: from mout2.freenet.de ([195.4.92.92]:33580 "EHLO mout2.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730892AbfDVTyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:54:54 -0400
X-Greylist: delayed 1548 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2019 15:54:53 EDT
Received: from [195.4.92.164] (helo=mjail1.freenet.de)
        by mout2.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.90_1 #2)
        id 1hIecg-0004lg-O2; Mon, 22 Apr 2019 21:29:02 +0200
Received: from [::1] (port=60450 helo=mjail1.freenet.de)
        by mjail1.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.90_1 #2)
        id 1hIecg-0008CA-NH; Mon, 22 Apr 2019 21:29:02 +0200
Received: from sub3.freenet.de ([195.4.92.122]:34902)
        by mjail1.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.90_1 #2)
        id 1hIeai-0007nF-1F; Mon, 22 Apr 2019 21:27:00 +0200
Received: from p2e5b8614.dip0.t-ipconnect.de ([46.91.134.20]:38444 helo=mail.maya.org)
        by sub3.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.90_1 #2)
        id 1hIeah-0006JQ-Hs; Mon, 22 Apr 2019 21:27:00 +0200
Received: internal info suppressed
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
References: <20190121134913.924726465@linuxfoundation.org>
 <20190121134914.421023706@linuxfoundation.org>
 <f55ad830-dd61-8ce2-7fa0-d33fb93c0b9c@01019freenet.de>
 <20190422172732.sneybhuwrreb7g2u@breakpoint.cc>
 <c9211352-3da4-6cb6-cd71-be0b9c0248d7@01019freenet.de>
 <20190422185710.3la4ayzxslafxwbn@breakpoint.cc>
From:   Andreas Hartmann <andihartmann@freenet.de>
Openpgp: preference=signencrypt
Autocrypt: addr=andreas@maya.org; prefer-encrypt=mutual; keydata=
 mQGiBDz/vtQRBAC+OSpes1p57fA8ENLYy3Nl/CpEvtRoDdhy7DPyc1+adE57vpK52naRfaZB
 f0RSMvIZwJYggMio+emiN5Du7kL9y2IEjmHBvp/1x68dEwswHP9X4hJmHmyOJL3IB2WsvEdh
 QF97913bWX34MYCeuOoSJ1OWvBLGfNs0zv70HOTfJwCgricyy8N1itEryLwoeu5HWz0SmDED
 /2IiuDhPZ332i0Ylp40RQb2Wb0xBvpscVeRZDItsYYbJ/Sgmso1sn93sFFWmmrvGUyg3MNCt
 +u+7P8Wg3VXte8cHbNwdzNtXHTfYyTcgZXC4xJN2akZt4pdR531mXyP2kFxmKtAEmW6bNpvV
 oNnkgZVWvoT4BHLloLzA62JUEgFJA/9dHilAVS3Ezv5ECB02Lt2vNNzMvPlyNbxBhWnrb6VC
 mFMCRg9bOK2io1zYb8C4gEpJ33wl8hEBxOWfCOEEKesAUCjViosNvxqGNtGWjk5p1O2QBWE2
 D6u5+itACQRqhmmgNl+dK6Of2yGG9GxOYWozIELEfL9ZB4xQ7A2tDFR0ZrRHQW5kcmVhcyBI
 YXJ0bWFubiAod2VpbCBkZXIgUmVjaG5lciBuZXUgaGVpc3N0KSA8YW5kcmVhc0BkdWFsYy5t
 YXlhLm9yZz6IYAQTEQIAIAUCTMsY3gIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJEBhU
 mcTgYeNVT1QAoJ4cJ2jl6Jgmi+PmWCXPk4m8lgAGAKCjkxgK/PjE3+cNsLa/xEpReqYwRrkB
 DQQ8/77WEAQAqBBex8oxPC1srpaSFbq8NCM/Gy7SKucKsQPqG/De46WQESbmnMElVft2xCBC
 rOJ7E02k10h/twe0yQnNdXMJDMDM0w0EEyX9ljekIr3SFbXpU2S4wUl3C6CW2hizUgOyLsg0
 chpfGMB9+wiVycyjZahafoc14wuuDj5BqWEOCccAAwcD/14lh1PTPKx4hs7ITtFZh5TI6+5f
 xAWIBBUeQL+GEt+CKwyNc/hWp8YTPJ3SAedmDrEMX+2yPO95KeIfg6bnnIVvI/aTR/vJFsWK
 GKMx+KaKx+IEwuhCpNIMUASpJWRvVlo3lMIvqAMJIBj79uKq/X9fppblcJst29QVO6aWf3Gh
 iEYEGBECAAYFAjz/vtYACgkQGFSZxOBh41VBAgCfZRiPCQ+jNvdT5iR2fEblqTtBrF0An0nb
 M8B1Lpkm44214BbtIQKneVrYiEYEGBECAAYFAjz/vtcACgkQGFSZxOBh41UjjgCgoua1QYf+
 FcHpxrRgoioO3D7ddkUAnAkRf8FH9i94x8f6LfS4npozycQc
Subject: Re: [PATCH 4.19 13/99] netfilter: nf_conncount: fix argument order to
 find_next_bit
Message-ID: <47f69e73-8104-aa58-44f2-b0d8fafd9e91@maya.org>
Date:   Mon, 22 Apr 2019 21:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422185710.3la4ayzxslafxwbn@breakpoint.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originated-At: 46.91.134.20!38444
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.19 at 20:57 Florian Westphal wrote:
> Andreas Hartmann <andihartmann@01019freenet.de> wrote:
>>> Could you at least tell us how you're using nf_conncount (nf/iptables
>>> rules)?
>>
>> # Generated by iptables-save v1.6.2 on Mon Apr 22 20:19:30 2019
>> *filter
>> :INPUT DROP [0:0]
>> :FORWARD ACCEPT [0:0]
>> :OUTPUT DROP [4423:248703]
>> -A INPUT -s 127.0.0.1/32 -d 239.255.255.250/32 -i lo -p udp -j ACCEPT
>> -A INPUT -p tcp -m tcp --dport 113 -j REJECT --reject-with icmp-port-unreachable
>> -A INPUT -d 255.255.255.255/32 -p udp -j ACCEPT
>> -A INPUT -d 224.0.0.1/32 -j ACCEPT
>> -A INPUT -s 127.0.0.1/32 -d 127.0.0.2/32 -i lo -j ACCEPT
>> -A INPUT -s 127.0.0.1/32 -d 127.0.0.1/32 -i lo -j ACCEPT
>> -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
>> -A INPUT -s 192.168.22.0/24 -j ACCEPT
>> -A INPUT -j LOG --log-prefix "In Input gesperrt: "
>> -A INPUT -s 169.254.2.1/32 -d 169.254.2.2/32 -i br1 -p tcp -m tcp --sport 80 -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -d 224.0.0.22/32 -o lo -p igmp -j ACCEPT
>> -A OUTPUT -d 192.168.6.173/32 -o br1 -p tcp -m tcp --dport 80 -j ACCEPT
>> -A OUTPUT -s 169.254.2.2/32 -d 239.255.255.250/32 -o br1 -p udp -j DROP
>> -A OUTPUT -s 192.168.22.6/32 -d 224.0.0.251/32 -o br1 -p udp -j ACCEPT
>> -A OUTPUT -s 127.0.0.1/32 -d 239.255.255.250/32 -o lo -p udp -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -d 255.255.255.255/32 -o br1 -p udp -m udp --dport 1900 -j ACCEPT
>> -A OUTPUT -s 127.0.0.1/32 -d 127.255.255.255/32 -o br1 -p udp -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -d 239.0.0.250/32 -o br1 -p igmp -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -d 239.255.255.250/32 -o br1 -p igmp -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -d 239.255.255.250/32 -o br1 -p udp -m udp --dport 1900 -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -d 239.1.1.1/32 -o br1 -p udp -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -d 239.1.1.1/32 -o br1 -p igmp -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -d 224.0.0.251/32 -o br1 -p igmp -j ACCEPT
>> -A OUTPUT -s 192.168.22.6/32 -p tcp -m tcp --dport 1935 -j ACCEPT
>> -A OUTPUT -s 192.168.22.0/24 -d 192.168.3.0/24 -j ACCEPT
>> -A OUTPUT -s 127.0.0.1/32 -d 127.0.0.2/32 -o lo -j ACCEPT
>> -A OUTPUT -s 127.0.0.1/32 -d 127.0.0.1/32 -o lo -j ACCEPT
>> -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
>> -A OUTPUT -s 192.168.22.0/24 -d 192.168.22.0/24 -j ACCEPT
>> -A OUTPUT -j LOG --log-prefix "In Output gesperrt: "
>> -A OUTPUT -s 169.254.2.2/32 -d 169.254.2.1/32 -o br1 -p tcp -m tcp --dport 80 -j ACCEPT
>> COMMIT
> 
> I don't see connlimit match is in use.
> 
> Could you post output of
> 
> lsmod | grep nf_conncount
> 
> and
> 
> grep CONNCOUNT ~/your_kernel_conf

True - it's not in use (it's not even configured) at all. I'm surprised that it seems to fix the problem anyway.
Ok - I'm testing few weeks more. If it comes up again: this has been a false positive.
If I can't see it any more - I wouldn't know what to do any further at the moment.

Regarding git bisect, the only other possible remaining changes would be at the moment

tty: Don't hold ldisc lock in tty_reopen() if ldisc present                     Dmitry Safonov
tty: Simplify tty->count math in tty_reopen()                                   Dmitry Safonov
tty: Hold tty_ldisc_lock() during tty_reopen()                                  Dmitry Safonov
tty/ldsem: Wake up readers after timed out down_write()                         Dmitry Safonov

But I don't know how this change could break video streaming using serviio ... .


Thanks
Andreas
