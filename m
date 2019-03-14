Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F12C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2AA20651
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCNCg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:36:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfCNCg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:36:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89D00AF58;
        Thu, 14 Mar 2019 02:36:26 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 14 Mar 2019 13:36:11 +1100
Cc:     John Crispin <john@phrozen.org>, Stefan Roese <sr@denx.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Armando Miraglia <arma2ff0@gmail.com>,
        Armando Miraglia <armax@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sankalpnegi2310@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in spi-mt7621.c
In-Reply-To: <CAJsYDVKwJZmaLMkzYOeGnhnor7rXe21Xwvogx7aPfzfXOdqZAg@mail.gmail.com>
References: <20190313122403.248873-1-armax@google.com> <eb85ea17-babd-fe3a-f0ff-9c7f13498bd1@gmail.com> <CAJsYDVKF-3jZo4E3EMiYOqeWXVLu0hBra6Qp0sFoCz8y=BAjSw@mail.gmail.com> <4789d739-d2b5-357b-b9d8-bfaf587d33fc@gmail.com> <4172ce05-8dfc-c956-6af0-47c8367c215e@denx.de> <87y35ipgkt.fsf@notabene.neil.brown.name> <CAJsYDVKwJZmaLMkzYOeGnhnor7rXe21Xwvogx7aPfzfXOdqZAg@mail.gmail.com>
Message-ID: <87mulyp4h0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Mar 14 2019, Chuanhong Guo wrote:

> Hi!
> On Thu, Mar 14, 2019 at 6:14 AM NeilBrown <neil@brown.name> wrote:
>>
>> [...]
>> My only small concern is that this driver was backported to openwrt
>> (4.14 based) and then reverted
>>
>> https://github.com/openwrt/openwrt/commit/749a29f76ca780d8df70a5163d43bbdc6f13ba3f
>>
>>  "This breaks some mt7621 devices."
>>
>> Possibly it was backported badly, or possibly there is a problem.
> Last time I backported the version with broken SPI modes so it got
> broken SPI CS1 support. There is one mt7621 router using SPI CS1 in
> OpenWrt and the backported driver broke it.
> It has been fixed by my two "drop broken spi modes" patches.

Ahh, thanks for the clarification.  Good to know all known problems are
fixed.

Thanks,
NeilBrown


>>
>> John: do you have any more details of the problem other than what is in
>> the commit message?
>>
>> Thanks,
>> NeilBrown
>
> Regards,
> Chuanhong Guo

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyJvhwACgkQOeye3VZi
gbnSyg/6A4cJK3Y6QVKHque374sHdHn+JkGuuP2+lNs/SQMknyXuHJiOQVWuJFh3
YthVDHhRodQM87ilVji48sJQEZoXkwC2mvglabGxL9ior1qGUYE01R3qp5OTcvZ9
UrMOJNILFKvfRh/u0ZcjntPj7DodjvkBFbJaWP96/PZQrrAMvjFlkYOVw/Bpnz8O
sZR8dkp7jytaX10hnEgLM/vvE98j0igoY8dOXIgd45ZY28tHpRfRxVFvUZfeOtfD
OcyaqtICFJaMcQOC1Ehfl/haems1rxNCaiJnQ/7ZJRpzz/pY16H7I9V1JxdS6oti
zwLbhp7qQHtyRxYAdlAUE6H4krLYC/EsJVIgOdMZyVTKEIdF5FAmTnibnoz5LMOW
RHVXRa93tgpKiANfM1suxjIA04HnpfSBwaCz/xmYOWjhRc5tkwYO57AaEdZA3AsQ
b1vD68vQCqMTrP5KtbQNFGih0upuQG+7xHUVHLHBgTy4zMgzHofEodSHjSxaiY2U
XLwcba3M92hO7z023P3vtLlgUhtOGsyJ1SFw/SxBaTUiv91kgQ5Kpg2FI5rxywXi
LYO7k+u2p1Y9MD5iOFUHSMabselNGPIZ3hGSRUehtK0tlowelR1UU6sc2r0Nw+JM
3Mttp/kKuoYjC5l57kHzUWo8hjoOniCPFBn49O6tm5EI8wgOSww=
=HXHg
-----END PGP SIGNATURE-----
--=-=-=--
