Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20201C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAEF20640
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQwUZqzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfJKPUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:20:50 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45486 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:20:50 -0400
Received: by mail-lj1-f176.google.com with SMTP id q64so10181541ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WNaPYY4RvdFo+wHTBLgOHo1NU3FZcZV5navNL82ItQs=;
        b=FQwUZqzqk+u1e/2gdXC3R1YyoUxPde83lHHEkEIv+iQmPDIucuxKHti8WPvO/7fzx9
         VDJGNUuqXCYkwi+xiagShxUqlBNsYB+i3oYfKWS/2vOSkUp+kp467f3Yax8Mh+uOlBOc
         uYZhWJ6dPSjGV1f2JLqgVnEbpw15rj0ur6eFE428xw27wQD2oi54Q+6EOeMd8jcZ+rrX
         IOoBLgQazng6KzEBccbnK0j3MhzYqHt92wxbHJcKDehv9MFT6qNXeVt55hGtJMtw5Bmm
         YopeURDjW/yfsZEk82jWY/piMe5h6AIrDXXR0tFBuIMh2ixBJ61vNnL4jnHwKV2Vh+bj
         JIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WNaPYY4RvdFo+wHTBLgOHo1NU3FZcZV5navNL82ItQs=;
        b=qvL4/SkYVirRadINli6qkWGHGQqfmMiPK+08cQUa9MgmauzjDP/olC6u6Kk9wZW5bF
         KaqTL3lUgSc1dRf0FLiNhdG8iJWSEX4WvReWb4YqdwRCZ03AcKt6AZYTEScnwQGpPdH/
         jOnf6l1nfuu9Azd/T3DXzh3EFcYmxNNZ7WB6MtKoNaML0a3xZeZKOzsAzXwN9YleBHkX
         NwLj3ytqVsrdY7uQHSN98lDZe+mMPWDOspQHlSvdlmptNF3Pzy7xMhoibLMu45oMWQuL
         iQs8dOz1Ndq3MftFIefyt4pFOR3fw5haTk2vfFZO85xvX14Xm6K+BNBzlR4AQi18nnql
         2fwQ==
X-Gm-Message-State: APjAAAVNVLAyor0XAM+LPiITbgGGQhptWaKxGQAAMj9KHayByzs+gvQO
        OFhFH0R2Rccd+4OSXxT4afCd72lUEVWevJtPYDP1GS8tLEU=
X-Google-Smtp-Source: APXvYqz7WYWtSv9EqDF/q8uJPWVUGt39Q2wGlcwjVtZoOAXikx2qlE3b0kNEW0ecp33XbsprrgULli2QubFcc0329hs=
X-Received: by 2002:a2e:9e85:: with SMTP id f5mr8473635ljk.235.1570807244756;
 Fri, 11 Oct 2019 08:20:44 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming.smartphone@gmail.com>
Date:   Fri, 11 Oct 2019 23:20:32 +0800
Message-ID: <CA+5xKD4rO8XhECpTYMFVC+gswq6OfK6qdRyDPnFMVLAhAFq4Rg@mail.gmail.com>
Subject: ET1505 Project for Diploma (Conversion) in Computer Networking at
 Singapore Polytechnic Year 2017
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <teo.en.ming.smartphone@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Primary Subject: ET1505 Project for Diploma (Conversion) in Computer
Networking at Singapore Polytechnic Year 2017

Secondary Subject: [ET1505 Project] Cisco Routers and Switches Actual
Hardware Configuration Files (Version 9 *FINAL SUBMISSION*)

Mr. Turritopsis Dohrnii Teo En Ming is the Project Leader for the
Project Team of three *continuing education* polytechnic students.

Version 8 link (dated 27 July 2017):
https://lists.freebsd.org/pipermail/freebsd-chat/2017-July/007146.html

1. ADMIN-BLDG-ROUTER
====================

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2017.08.02 21:32:41 =~=~=~=~=~=~=~=~=~=~=~=
sh run
Building configuration...

Current configuration : 2016 bytes
!
! Last configuration change at 06:53:38 UTC Wed Aug 2 2017
version 15.2
no service timestamps debug uptime
no service timestamps log uptime
no service password-encryption
!
hostname ADMIN-BLDG-ROUTER
!
boot-start-marker
boot-end-marker
!
!
enable secret 5 $1$mERr$El.YInibhgLj/4DvLcVWc0
!
no aaa new-model
!
no ipv6 cef
!
!
!
ip dhcp excluded-address 223.0.0.97
!
ip dhcp pool ADMIN-POOL
 network 223.0.0.96 255.255.255.224
 default-router 223.0.0.97
 dns-server 8.8.8.8 8.8.4.4
 domain-name xyz-research.com.au
!
!
no ip cef
multilink bundle-name authenticated
!
!
!
!
license udi pid CISCO2911/K9 sn FGL16441038
!
!
!
redundancy
!
!
!
!
!
!
interface Loopback0
 ip address 4.4.4.4 255.255.255.255
!
interface Embedded-Service-Engine0/0
 no ip address
 shutdown
!
interface GigabitEthernet0/0
 ip address 223.0.0.170 255.255.255.252
 duplex auto
 speed auto
!
interface GigabitEthernet0/1
 ip address 223.0.0.97 255.255.255.224
 ip access-group INTERNET_ACCESS in
 duplex auto
 speed auto
!
interface GigabitEthernet0/2
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface Serial0/0/0
 no ip address
 shutdown
 clock rate 125000
!
interface Serial0/0/1
 no ip address
 shutdown
 clock rate 125000
!
!
router ospf 50
 network 223.0.0.97 0.0.0.0 area 0
 network 223.0.0.170 0.0.0.0 area 0
!
ip forward-protocol nd
!
no ip http server
no ip http secure-server
ip flow-export version 9
!
!
ip access-list extended INTERNET_ACCESS
 deny   tcp 223.0.0.112 0.0.0.15 any eq ftp-data
 deny   tcp 223.0.0.112 0.0.0.15 any eq ftp
 permit ip any any
 deny   ip any any
!
!
!
!
control-plane
!
!
!
line con 0
 exec-timeout 0 0
 password teoenming
 logging synchronous
 login
line aux 0
line 2
 no activation-character
 no exec
 transport preferred none
 transport input all
 transport output lat pad telnet rlogin lapb-ta mop udptn v120 ssh
 stopbits 1
line vty 0 4
 password teoenming
 login
 transport input all
line vty 5 15
 password teoenming
 login
 transport input all
!
scheduler allocate 20000 1000
!
end

ADMIN-BLDG-ROUTER#

2. BORDER-ROUTER
================

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2017.08.02 21:33:23 =~=~=~=~=~=~=~=~=~=~=~=
sh run
Building configuration...

Current configuration : 1777 bytes
!
! Last configuration change at 06:33:49 UTC Wed Aug 2 2017
version 15.2
no service timestamps debug uptime
no service timestamps log uptime
no service password-encryption
!
hostname BORDER-ROUTER
!
boot-start-marker
boot-end-marker
!
!
enable secret 5 $1$mERr$El.YInibhgLj/4DvLcVWc0
!
no aaa new-model
!
no ipv6 cef
!
!
!
!
!
no ip cef
multilink bundle-name authenticated
!
!
!
!
license udi pid CISCO2911/K9 sn FGL16441026
!
!
username MAIN-BLDG-ROUTER password 0 teo-en-ming
!
redundancy
!
!
!
!
!
!
interface Loopback0
 ip address 3.3.3.3 255.255.255.255
!
interface Embedded-Service-Engine0/0
 no ip address
 shutdown
!
interface GigabitEthernet0/0
 ip address 223.0.0.169 255.255.255.252
 duplex auto
 speed auto
!
interface GigabitEthernet0/1
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface GigabitEthernet0/2
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface Serial0/0/0
 ip address 200.200.100.2 255.255.255.252
 clock rate 56000
!
interface Serial0/0/1
 ip address 223.0.0.166 255.255.255.252
 encapsulation ppp
 ppp authentication chap
!
!
router ospf 50
 network 223.0.0.166 0.0.0.0 area 0
 network 223.0.0.169 0.0.0.0 area 0
 default-information originate
!
ip forward-protocol nd
!
no ip http server
no ip http secure-server
ip flow-export version 9
!
ip route 0.0.0.0 0.0.0.0 200.200.100.1
!
!
!
!
control-plane
!
!
!
line con 0
 exec-timeout 0 0
 password teoenming
 logging synchronous
 login
line aux 0
line 2
 no activation-character
 no exec
 transport preferred none
 transport input all
 transport output lat pad telnet rlogin lapb-ta mop udptn v120 ssh
 stopbits 1
line vty 0 4
 password teoenming
 login
 transport input all
line vty 5 15
 password teoenming
 login
 transport input all
!
scheduler allocate 20000 1000
!
end

BORDER-ROUTER#

3. BRANCH-ROUTER
================

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2017.08.02 21:31:17 =~=~=~=~=~=~=~=~=~=~=~=
sh run
Building configuration...

Current configuration : 1709 bytes
!
! Last configuration change at 07:10:43 UTC Wed Aug 2 2017
version 15.2
no service timestamps debug uptime
no service timestamps log uptime
no service password-encryption
!
hostname BRANCH-ROUTER
!
boot-start-marker
boot-end-marker
!
!
enable secret 5 $1$mERr$El.YInibhgLj/4DvLcVWc0
!
no aaa new-model
!
no ipv6 cef
!
!
!
!
!
no ip cef
multilink bundle-name authenticated
!
!
!
!
license udi pid CISCO2911/K9 sn FGL1644101T
!
!
username MAIN-BLDG-ROUTER password 0 teo-en-ming
!
redundancy
!
!
!
!
!
!
interface Loopback0
 ip address 1.1.1.1 255.255.255.255
!
interface Embedded-Service-Engine0/0
 no ip address
 shutdown
!
interface GigabitEthernet0/0
 ip address 223.0.0.129 255.255.255.240
 duplex auto
 speed auto
!
interface GigabitEthernet0/1
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface GigabitEthernet0/2
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface Serial0/0/0
 ip address 223.0.0.161 255.255.255.252
 encapsulation ppp
 ppp authentication chap
 clock rate 56000
!
interface Serial0/0/1
 no ip address
 shutdown
 clock rate 125000
!
!
router ospf 50
 network 223.0.0.129 0.0.0.0 area 0
 network 223.0.0.161 0.0.0.0 area 0
!
ip forward-protocol nd
!
no ip http server
no ip http secure-server
ip flow-export version 9
!
!
!
!
!
control-plane
!
!
!
line con 0
 exec-timeout 0 0
 password teoenming
 logging synchronous
 login
line aux 0
line 2
 no activation-character
 no exec
 transport preferred none
 transport input all
 transport output lat pad telnet rlogin lapb-ta mop udptn v120 ssh
 stopbits 1
line vty 0 4
 password teoenming
 login
 transport input all
line vty 5 15
 password teoenming
 login
 transport input all
!
scheduler allocate 20000 1000
!
end

BRANCH-ROUTER#

4. ISP ROUTER
=============

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2017.08.02 21:35:01 =~=~=~=~=~=~=~=~=~=~=~=
sh run
Building configuration...

Current configuration : 1489 bytes
!
! Last configuration change at 16:17:32 UTC Wed Aug 2 2017
version 15.2
no service timestamps debug uptime
no service timestamps log uptime
no service password-encryption
!
hostname ISP
!
boot-start-marker
boot-end-marker
!
!
enable secret 5 $1$mERr$El.YInibhgLj/4DvLcVWc0
!
no aaa new-model
!
no ipv6 cef
!
!
!
!
!
no ip cef
multilink bundle-name authenticated
!
!
!
!
license udi pid CISCO2911/K9 sn FGL16441032
!
!
!
redundancy
!
!
!
!
!
!
interface Embedded-Service-Engine0/0
 no ip address
 shutdown
!
interface GigabitEthernet0/0
 ip address 150.13.2.2 255.255.255.252
 duplex auto
 speed auto
!
interface GigabitEthernet0/1
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface GigabitEthernet0/2
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface Serial0/0/0
 ip address 200.200.100.1 255.255.255.252
!
interface Serial0/0/1
 no ip address
 shutdown
 clock rate 125000
!
!
ip forward-protocol nd
!
no ip http server
no ip http secure-server
ip flow-export version 9
!
ip route 223.0.0.0 255.255.255.0 200.200.100.2
!
!
!
!
control-plane
!
!
!
line con 0
 exec-timeout 0 0
 password teoenming
 logging synchronous
 login
line aux 0
line 2
 no activation-character
 no exec
 transport preferred none
 transport input all
 transport output lat pad telnet rlogin lapb-ta mop udptn v120 ssh
 stopbits 1
line vty 0 4
 password teoenming
 login
 transport input all
line vty 5 15
 password teoenming
 login
 transport input all
!
scheduler allocate 20000 1000
!
end

ISP#

5. MAIN-BLDG-ROUTER
===================

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2017.08.02 21:32:01 =~=~=~=~=~=~=~=~=~=~=~=
sh run
Building configuration...

Current configuration : 2873 bytes
!
! Last configuration change at 16:17:35 UTC Wed Aug 2 2017
! NVRAM config last updated at 12:27:36 UTC Wed Aug 2 2017
! NVRAM config last updated at 12:27:36 UTC Wed Aug 2 2017
version 15.2
no service timestamps debug uptime
no service timestamps log uptime
no service password-encryption
!
hostname MAIN-BLDG-ROUTER
!
boot-start-marker
boot-end-marker
!
!
enable secret 5 $1$mERr$El.YInibhgLj/4DvLcVWc0
!
no aaa new-model
!
no ipv6 cef
!
!
!
!
!
no ip cef
multilink bundle-name authenticated
!
!
!
!
license udi pid CISCO2911/K9 sn FGL1644101V
!
!
username BRANCH-ROUTER password 0 teo-en-ming
username BORDER-ROUTER password 0 teo-en-ming
!
redundancy
!
!
!
!
!
!
interface Loopback0
 ip address 2.2.2.2 255.255.255.255
!
interface Embedded-Service-Engine0/0
 no ip address
 shutdown
!
interface GigabitEthernet0/0
 no ip address
 duplex auto
 speed auto
!
interface GigabitEthernet0/0.10
 encapsulation dot1Q 10
 ip address 223.0.0.1 255.255.255.192
 ip access-group TIME-BASED-ACL in
!
interface GigabitEthernet0/0.20
 encapsulation dot1Q 20
 ip address 223.0.0.65 255.255.255.224
!
interface GigabitEthernet0/0.30
 encapsulation dot1Q 30
 ip address 223.0.0.145 255.255.255.248
!
interface GigabitEthernet0/0.99
 encapsulation dot1Q 99
 ip address 223.0.0.153 255.255.255.248
!
interface GigabitEthernet0/1
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface GigabitEthernet0/2
 no ip address
 shutdown
 duplex auto
 speed auto
!
interface Serial0/0/0
 ip address 223.0.0.165 255.255.255.252
 encapsulation ppp
 ppp authentication chap
 clock rate 56000
!
interface Serial0/0/1
 ip address 223.0.0.162 255.255.255.252
 encapsulation ppp
 ppp authentication chap
!
!
router ospf 50
 network 223.0.0.1 0.0.0.0 area 0
 network 223.0.0.65 0.0.0.0 area 0
 network 223.0.0.145 0.0.0.0 area 0
 network 223.0.0.153 0.0.0.0 area 0
 network 223.0.0.162 0.0.0.0 area 0
 network 223.0.0.165 0.0.0.0 area 0
!
ip forward-protocol nd
!
no ip http server
no ip http secure-server
ip flow-export version 9
!
!
ip access-list extended TIME-BASED-ACL
 permit tcp 223.0.0.0 0.0.0.63 host 223.0.0.146 eq 443 time-range
research-access-int-web
 permit tcp 223.0.0.0 0.0.0.63 host 223.0.0.146 eq www time-range
research-access-int-web
 deny   tcp 223.0.0.0 0.0.0.63 host 223.0.0.146 eq 443
 deny   tcp 223.0.0.0 0.0.0.63 host 223.0.0.146 eq www
 permit ip any any
!
!
!
!
control-plane
!
!
!
line con 0
 exec-timeout 0 0
 password teoenming
 logging synchronous
 login
line aux 0
line 2
 no activation-character
 no exec
 transport preferred none
 transport input all
 transport output lat pad telnet rlogin lapb-ta mop udptn v120 ssh
 stopbits 1
line vty 0 4
 password teoenming
 login
 transport input all
line vty 5 15
 password teoenming
 login
 transport input all
!
scheduler allocate 20000 1000
time-range research-access-int-web
 periodic weekdays 7:00 to 19:00
!
!
end

MAIN-BLDG-ROUTER#

6. FLOOR1SW
===========

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2017.08.02 21:36:14 =~=~=~=~=~=~=~=~=~=~=~=
sh run
Building configuration...

Current configuration : 2831 bytes
!
version 12.2
no service pad
no service timestamps debug uptime
no service timestamps log uptime
no service password-encryption
!
hostname FLOOR1SW
!
enable secret 5 $1$mERr$El.YInibhgLj/4DvLcVWc0
!
no aaa new-model
system mtu routing 1500
ip subnet-zero
!
!
!
!
no file verify auto
spanning-tree mode pvst
spanning-tree portfast default
spanning-tree portfast bpduguard default
spanning-tree extend system-id
!
vlan internal allocation policy ascending
!
interface FastEthernet0/1
 switchport trunk allowed vlan 10,20,30,99
 switchport mode trunk
!
interface FastEthernet0/2
 switchport trunk allowed vlan 10,20,30,99
 switchport mode trunk
!
interface FastEthernet0/3
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/4
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/5
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/6
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/7
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/8
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/9
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/10
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/11
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/12
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/13
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/14
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/15
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/16
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/17
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/18
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/19
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/20
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/21
 switchport access vlan 30
 switchport mode access
!
interface FastEthernet0/22
 switchport access vlan 99
 switchport mode access
!
interface FastEthernet0/23
 switchport access vlan 99
 switchport mode access
!
interface FastEthernet0/24
 switchport access vlan 99
 switchport mode access
!
interface GigabitEthernet0/1
!
interface GigabitEthernet0/2
!
interface Vlan1
 no ip address
 no ip route-cache
 shutdown
!
interface Vlan99
 ip address 223.0.0.154 255.255.255.248
 no ip route-cache
!
ip default-gateway 223.0.0.153
ip http server
!
control-plane
!
!
line con 0
 exec-timeout 0 0
 password teoenming
 logging synchronous
 login
line vty 0 4
 password teoenming
 login
line vty 5 15
 password teoenming
 login
!
end

FLOOR1SW#

7. FLOOR2SW
===========

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2017.08.02 21:37:00 =~=~=~=~=~=~=~=~=~=~=~=
sh run
Building configuration...

Current configuration : 2831 bytes
!
version 12.2
no service pad
no service timestamps debug uptime
no service timestamps log uptime
no service password-encryption
!
hostname FLOOR2SW
!
enable secret 5 $1$mERr$El.YInibhgLj/4DvLcVWc0
!
no aaa new-model
system mtu routing 1500
ip subnet-zero
!
!
!
!
no file verify auto
spanning-tree mode pvst
spanning-tree portfast default
spanning-tree portfast bpduguard default
spanning-tree extend system-id
!
vlan internal allocation policy ascending
!
interface FastEthernet0/1
 switchport trunk allowed vlan 10,20,30,99
 switchport mode trunk
!
interface FastEthernet0/2
 switchport trunk allowed vlan 10,20,30,99
 switchport mode trunk
!
interface FastEthernet0/3
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/4
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/5
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/6
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/7
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/8
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/9
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/10
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/11
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/12
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/13
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/14
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/15
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/16
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/17
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/18
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/19
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/20
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/21
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/22
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/23
 switchport access vlan 99
 switchport mode access
!
interface FastEthernet0/24
 switchport access vlan 99
 switchport mode access
!
interface GigabitEthernet0/1
!
interface GigabitEthernet0/2
!
interface Vlan1
 no ip address
 no ip route-cache
 shutdown
!
interface Vlan99
 ip address 223.0.0.155 255.255.255.248
 no ip route-cache
!
ip default-gateway 223.0.0.153
ip http server
!
control-plane
!
!
line con 0
 exec-timeout 0 0
 password teoenming
 logging synchronous
 login
line vty 0 4
 password teoenming
 login
line vty 5 15
 password teoenming
 login
!
end

FLOOR2SW#

8. FLOOR3SW
===========

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2017.08.02 21:37:32 =~=~=~=~=~=~=~=~=~=~=~=
sh run
Building configuration...

Current configuration : 2846 bytes
!
version 12.2
no service pad
no service timestamps debug uptime
no service timestamps log uptime
no service password-encryption
!
hostname FLOOR3SW
!
enable secret 5 $1$mERr$El.YInibhgLj/4DvLcVWc0
!
no aaa new-model
system mtu routing 1500
ip subnet-zero
!
!
!
!
no file verify auto
spanning-tree mode pvst
spanning-tree portfast default
spanning-tree portfast bpduguard default
spanning-tree extend system-id
!
vlan internal allocation policy ascending
!
interface FastEthernet0/1
 switchport trunk allowed vlan 10,20,30,99
 switchport mode trunk
!
interface FastEthernet0/2
 switchport trunk allowed vlan 10,20,30,99
 switchport mode trunk
!
interface FastEthernet0/3
 switchport trunk allowed vlan 10,20,30,99
 switchport mode trunk
!
interface FastEthernet0/4
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/5
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/6
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/7
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/8
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/9
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/10
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/11
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/12
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/13
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/14
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/15
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/16
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/17
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/18
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/19
 switchport access vlan 10
 switchport mode access
!
interface FastEthernet0/20
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/21
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/22
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/23
 switchport access vlan 20
 switchport mode access
!
interface FastEthernet0/24
 switchport access vlan 99
 switchport mode access
!
interface GigabitEthernet0/1
!
interface GigabitEthernet0/2
!
interface Vlan1
 no ip address
 no ip route-cache
 shutdown
!
interface Vlan99
 ip address 223.0.0.156 255.255.255.248
 no ip route-cache
!
ip default-gateway 223.0.0.153
ip http server
!
control-plane
!
!
line con 0
 exec-timeout 0 0
 password teoenming
 logging synchronous
 login
line vty 0 4
 password teoenming
 login
line vty 5 15
 password teoenming
 login
!
end

FLOOR3SW#








Yours sincerely,

Mr. Turritopsis Dohrnii Teo En Ming (Zhang Enming) @ Time Traveller
Diploma (Conversion) in Computer Networking (based on Cisco Certified
Network Associate (CCNA) curriculum)
4 Distinctions and Grade A for ET1505 Project
Singapore Polytechnic
Academic Year October 2016 to October 2017

Team Members:

Teo En Ming (Project Leader)
Er Peh Nak
Dennis Chua Lee Boo

PUBLISHED 11 OCTOBER 2019 FRIDAY 11:06 PM SINGAPORE TIME GMT+8
