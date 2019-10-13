Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF5DC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5740C20659
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 18:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VxtvlICW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfJMSm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 14:42:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:32911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfJMSm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 14:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570992113;
        bh=8D3QySR8QYt/OLa5e0b+l6cv0uIB1uYUh4eOufQv0Sw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VxtvlICWnEeMdR0FAVjFGtXlxZ22d9Wr3BSikA5yuF4/YCFnBW5OeLDQmXClgNYZB
         E0dJshM3GBLeDaXSpxDl9pXBtAahtqbxBlsQpSHa6+jRjtGZWMe1/GsMnp89+hzhEv
         8nb7k0m8AMq+gvP+ucV2aEUcuI8euQY3v8LJLJRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw7V-1hazze0OLj-00j5l6; Sun, 13
 Oct 2019 20:41:53 +0200
Subject: Re: [PATCH v1 3/3] ARM: dts: bcm2711: Enable GENET support for the
 RPi4
To:     Florian Fainelli <f.fainelli@gmail.com>, matthias.bgg@kernel.org,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Eric Anholt <eric@anholt.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191011184822.866-1-matthias.bgg@kernel.org>
 <20191011184822.866-4-matthias.bgg@kernel.org>
 <a514751e-e82a-b5ea-34d3-46468c851a80@gmail.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <c7fac096-4a0a-1d52-2284-4fe86554fbc8@gmx.net>
Date:   Sun, 13 Oct 2019 20:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a514751e-e82a-b5ea-34d3-46468c851a80@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:jaIkXziA0ZiyqtSywENbnXByWr9/ua/7ampTfGe+MOY4GUzAzKW
 YHhJeG7fNYknbq2uYPRd1hgVBoVYSqe9X2GX8PrbWwA8c5hlD4rEKNo3H0bLtiIYD5b/MgI
 pDhadMQdbyMDPnQmK96FHZHn6rqAQVwJ36lCQdxY3+WwpfcGKXs25y6372lc5BpY1FhvKeN
 UXjLpjEarqA9BtQcBfEQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eZ/z0o+61/g=:vkN0uoedVvsd9iVqPUk2Vd
 htLHK7eVvRpiBUYBE6f4RgucN5eI/EPosmhlSQKVFD9r3n7hhYOz0duxRWqfdbhfrwLNJHinn
 vnAZnqdykjR0UyLSCJOvMaqHfRBOxXaC5blwgUHaGOuDTDmjr8ROpfqhV/dnskoR0ybOtEzKV
 6a5tuqK7hMTOvd7ZNezQDQik3PyhU1IT9mGdtCg0XcsS/Q3lCkne931viQNGUxyH4MhuOSCbP
 Ovsn+cEX+9PUxJeSk5qcjfJhxlrK12OxibYY/ZVzcgsSe0msJi/vMs26ZVb9i+SUktu1/Msv3
 Po4tXToxHdBkycSifjir+BZMedwEpNFCNbmmHmPXvpvEmE8KPa9S5Sis/vP7tsNHoY8jcBwo4
 8oXHc5OSR+R+nVMUCyXNwOHM8WTngdQeZPRscgAT5jQC6DXvbAz3Sh9PRzHMg40KjPRQAZxfZ
 doNKkWf2kHusRrRMeohJTlAPQv0B97hvbz1+PgslgiFLN/m+ZugMxeJynd8VAo5qbO6xRqELL
 yc4vITAoYbzDt4yAjFV4EWZxyIZvyIBVbepP90ugvTix0e5Hnq0U1KJko+NbB4HXkRN8ohV4/
 WvE80/GiYMT1X/T58q3qlP69NbbvlvkK51CVTpjg7/+n0VGTBkK5fH66Cf+6lGXqmMCfBqPMF
 fAicmwebtS94Z0aFWvSbp/FioaA7mlN5/COVkA+VoyOOyp+Lfp4woqjwLlgel7anaI3eMPLU+
 ZP3ahL3Z2Ok2cfoI7kLz4agBM5T+5wofsDXNrRKGTtNt0yCTYDwal+buQjZBOeKlR69hPL4Sb
 bGi5ukXSdXTTbycKXJmi1fO1Y7gNEslag7H4/NxAPnfQ+ca9rvs9LL+vCDTn34/2LZpCopuly
 VgEnJEkb1P1VMNUml04bSZnP7I4FlormyIzMJ4y1R4TQMU/5r/MSS6zVurJMIQeH+PIJxVtvp
 yQ/yjykfHtQtbHFqhPCWId0k/ImM9drXztSK3uJMCyylqzuauaHOn1BEKooJWb1f2JAB5H3LO
 y/LxxEHG6GSkYkWdjMOpn1WqigmuWaNUv4oHRzWI9t9w+ZnqBJioRarMHqsZ9A62grgvf/EAD
 4WPC5hNa5i2rwjPnYgh/FyEMjbQuyJbbB/4/AnljrDE88w38E1gZtoj8KeNm2jgTqGmMb29Is
 Il9pzh6TK1hF+nUs9OmMYj8+uU7vtAT8NSRr9cgkPwJVcabwVhar9t8GpWNvCdCikiGFO1atQ
 6YI0zuJEWoP5vMFwKx/aixTVfqNY+gjGL7tbwZsTOcUN0Dcq/o+NwfbyDohs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Am 11.10.19 um 21:31 schrieb Florian Fainelli:
> On 10/11/19 11:48 AM, matthias.bgg@kernel.org wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> Enable Gigabit Ethernet support on the Raspberry Pi 4
>> Model B.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>
>> ---
>>
>>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 22 ++++++++++++++++++++++
>>  arch/arm/boot/dts/bcm2711.dtsi        | 18 ++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/=
bcm2711-rpi-4-b.dts
>> index cccc1ccd19be..958553d62670 100644
>> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>> @@ -97,6 +97,28 @@
>>  	status =3D "okay";
>>  };
>>
>> +&genet {
>> +	phy-handle =3D <&phy1>;
>> +	phy-mode =3D "rgmii";
> Can you check that things still work against David Miller's net-next?
> Tree, in particular the BCM54213PE PHY might be matched by the BCM54210E
> entry in drivers/net/phy/broadcom.c and I just fixed an issue in how
> RGMII delays were configured:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commi=
t/?id=3Dfea7fda7f50a6059220f83251e70709e45cc8040
>
> This might require you to change the 'phy-mode' property to what is
> appropriate.

i applied your changes, kept the phy-mode above and the interfaces cames
up. But there is a lot of packet loss using ping. After applying this
downstream patch [1] the packet loss doesn't occur.

Is the packet loss a possible cause of the wrong phy-mode and mentioned
patch only a workaround?

[1] -
https://github.com/raspberrypi/linux/commit/360c8e98883f9cd075564be8a7fc25=
ac0785dee4

