Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03021C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CE620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfDVSwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:52:07 -0400
Received: from mout3.freenet.de ([195.4.92.93]:46450 "EHLO mout3.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfDVSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:52:07 -0400
Received: from [195.4.92.165] (helo=mjail2.freenet.de)
        by mout3.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.90_1 #2)
        id 1hIe2s-0003Qn-9H; Mon, 22 Apr 2019 20:52:02 +0200
Received: from [::1] (port=51842 helo=mjail2.freenet.de)
        by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.90_1 #2)
        id 1hIe2s-0001UO-8W; Mon, 22 Apr 2019 20:52:02 +0200
Received: from sub6.freenet.de ([195.4.92.125]:38672)
        by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.90_1 #2)
        id 1hIe0e-00081g-Qc; Mon, 22 Apr 2019 20:49:44 +0200
Received: from p2e5b8614.dip0.t-ipconnect.de ([46.91.134.20]:38094 helo=mail.maya.org)
        by sub6.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.90_1 #2)
        id 1hIe0d-0001Ws-M2; Mon, 22 Apr 2019 20:49:44 +0200
Received: internal info suppressed
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
References: <20190121134913.924726465@linuxfoundation.org>
 <20190121134914.421023706@linuxfoundation.org>
 <f55ad830-dd61-8ce2-7fa0-d33fb93c0b9c@01019freenet.de>
 <20190422172732.sneybhuwrreb7g2u@breakpoint.cc>
From:   Andreas Hartmann <andihartmann@01019freenet.de>
Openpgp: preference=signencrypt
Autocrypt: addr=andihartmann@01019freenet.de; keydata=
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
Message-ID: <c9211352-3da4-6cb6-cd71-be0b9c0248d7@01019freenet.de>
Date:   Mon, 22 Apr 2019 20:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422172732.sneybhuwrreb7g2u@breakpoint.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originated-At: 46.91.134.20!38094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.19 at 19:27 Florian Westphal wrote:
> Andreas Hartmann <andihartmann@01019freenet.de> wrote:
>> Since 4.19.17, I'm facing problems during streaming of videos I've never seen before. This means:
>>
>> - video from internet stutters although enough data flow can be seen in bmon.
>> - gpu is locked:
>>   radeon 0000:0a:00.0: ring 0 stalled for more than 14084msec
>>   radeon 0000:0a:00.0: GPU lockup (current fence id 0x0000000000053ed7 last fence id 0x0000000000053f0f on ring 0)
>> - The connection of videos streamed locally by the machine for a TV suddenly breaks (upnp - serviio as server).
>>
>> After very long time of testing, I detected, that removing the complete patch series for 4.19.17 regarding netfilter: nf_conncount makes the problem disappear.
>>
>> Please remove / fix this patchset!
> 
> The state in 4.19.y is same as in mainline.

I don't use mainline.

> Could you at least tell us how you're using nf_conncount (nf/iptables
> rules)?

The host is a Ryzen 7 1700 CPU, containing 4 kvm VMs, one ethernet interface, 2 bridges (2 different networks). One VM works as a bridge between both networks.
The iptables rules are the following:

# Generated by iptables-save v1.6.2 on Mon Apr 22 20:19:30 2019
*filter
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT DROP [4423:248703]
-A INPUT -s 127.0.0.1/32 -d 239.255.255.250/32 -i lo -p udp -j ACCEPT
-A INPUT -p tcp -m tcp --dport 113 -j REJECT --reject-with icmp-port-unreachable
-A INPUT -d 255.255.255.255/32 -p udp -j ACCEPT
-A INPUT -d 224.0.0.1/32 -j ACCEPT
-A INPUT -s 127.0.0.1/32 -d 127.0.0.2/32 -i lo -j ACCEPT
-A INPUT -s 127.0.0.1/32 -d 127.0.0.1/32 -i lo -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -s 192.168.22.0/24 -j ACCEPT
-A INPUT -j LOG --log-prefix "In Input gesperrt: "
-A INPUT -s 169.254.2.1/32 -d 169.254.2.2/32 -i br1 -p tcp -m tcp --sport 80 -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -d 224.0.0.22/32 -o lo -p igmp -j ACCEPT
-A OUTPUT -d 192.168.6.173/32 -o br1 -p tcp -m tcp --dport 80 -j ACCEPT
-A OUTPUT -s 169.254.2.2/32 -d 239.255.255.250/32 -o br1 -p udp -j DROP
-A OUTPUT -s 192.168.22.6/32 -d 224.0.0.251/32 -o br1 -p udp -j ACCEPT
-A OUTPUT -s 127.0.0.1/32 -d 239.255.255.250/32 -o lo -p udp -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -d 255.255.255.255/32 -o br1 -p udp -m udp --dport 1900 -j ACCEPT
-A OUTPUT -s 127.0.0.1/32 -d 127.255.255.255/32 -o br1 -p udp -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -d 239.0.0.250/32 -o br1 -p igmp -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -d 239.255.255.250/32 -o br1 -p igmp -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -d 239.255.255.250/32 -o br1 -p udp -m udp --dport 1900 -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -d 239.1.1.1/32 -o br1 -p udp -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -d 239.1.1.1/32 -o br1 -p igmp -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -d 224.0.0.251/32 -o br1 -p igmp -j ACCEPT
-A OUTPUT -s 192.168.22.6/32 -p tcp -m tcp --dport 1935 -j ACCEPT
-A OUTPUT -s 192.168.22.0/24 -d 192.168.3.0/24 -j ACCEPT
-A OUTPUT -s 127.0.0.1/32 -d 127.0.0.2/32 -o lo -j ACCEPT
-A OUTPUT -s 127.0.0.1/32 -d 127.0.0.1/32 -o lo -j ACCEPT
-A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A OUTPUT -s 192.168.22.0/24 -d 192.168.22.0/24 -j ACCEPT
-A OUTPUT -j LOG --log-prefix "In Output gesperrt: "
-A OUTPUT -s 169.254.2.2/32 -d 169.254.2.1/32 -o br1 -p tcp -m tcp --dport 80 -j ACCEPT
COMMIT
# Completed on Mon Apr 22 20:19:30 2019


br0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9000
        ether .........  txqueuelen 1000  (Ethernet)
        RX packets 1376  bytes 139220 (135.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

br1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1512
        inet 192.168.22.6  netmask 255.255.255.0  broadcast 192.168.22.255
        ether .........  txqueuelen 1000  (Ethernet)
        RX packets 1161816  bytes 2806028482 (2.6 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1427306  bytes 2032637199 (1.8 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1512
        ether .........  txqueuelen 1000  (Ethernet)
        RX packets 119990  bytes 110191277 (105.0 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 204094  bytes 234832004 (223.9 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 36  memory 0xfc8c0000-fc8e0000

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 2474  bytes 16626724 (15.8 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2474  bytes 16626724 (15.8 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tap0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1512
        ether ............  txqueuelen 1000  (Ethernet)
        RX packets 1164109  bytes 3022066875 (2.8 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 984171  bytes 56305461 (53.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tap1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9000
        ether .........  txqueuelen 1000  (Ethernet)
        RX packets 1044034  bytes 66058845 (62.9 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1220061  bytes 3029057018 (2.8 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tap2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9000
        ether ..........  txqueuelen 1000  (Ethernet)
        RX packets 1216429  bytes 3011285937 (2.8 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1038397  bytes 65034965 (62.0 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tap3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9000
        ether ............ txqueuelen 1000  (Ethernet)
        RX packets 19875  bytes 29951674 (28.5 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 23283  bytes 13365374 (12.7 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tap4: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1512
        ether ............  txqueuelen 1000  (Ethernet)
        RX packets 363077  bytes 24587603 (23.4 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 823604  bytes 2081985009 (1.9 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

> Could you test with debugging (KASAN, CONFIG_PROVE_RCU etc). enabled?

I don't know what you're expecting here exactly - sorry. Testing is not that easy as I don't know how to force the error.
After removing the "netfilter: nf_conncount" patches, I didn't see the problem any more - same as before 4.19.17.

> I'm really surprised about this report, before the backport nf_conncount
> caused frequent kernel crashes, how does reverting even work...?

I never had any problem w/ iptables before - it's been working always just as it should!


Thanks!
Regards
Andreas
