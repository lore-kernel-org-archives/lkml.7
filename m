Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB5FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46D320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfDHHqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:46:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfDHHqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:46:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36958AFCF;
        Mon,  8 Apr 2019 07:46:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     kernel test robot <rong.a.chen@intel.com>
Date:   Mon, 08 Apr 2019 17:45:50 +1000
Cc:     Jens Axboe <axboe@kernel.dk>, Xiao Ni <xni@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        lkp@01.org
Subject: Re: [MD] 4bc034d353: aim7.jobs-per-min -86.0% regression
In-Reply-To: <20190408071204.GG11264@shao2-debian>
References: <20190408071204.GG11264@shao2-debian>
Message-ID: <875zrpym6p.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Apr 08 2019, kernel test robot wrote:

> Greeting,
>
> FYI, we noticed a -86.0% regression of aim7.jobs-per-min due to commit:

That is expected.  The following commit
  2bc13b83e6298486371761de503faeffd15b7534
should restore the performance.

NeilBrown



>
>
> commit: 4bc034d35377196c854236133b07730a777c4aba ("Revert "MD: fix lock contention for flush bios"")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.2/block
>
> in testcase: aim7
> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
> with following parameters:
>
> 	disk: 4BRD_12G
> 	md: RAID0
> 	fs: xfs
> 	test: sync_disk_rw
> 	load: 300
> 	cpufreq_governor: performance
>
> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
>
>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyq/DAACgkQOeye3VZi
gbn1+BAAlAciuUy7lG/qqab1gfE1NEBJZRjGSxNHfvdl12n3LKacNCbTsy8EgkmU
ofGjaGGqj8UNZvRzH+ThyOR5LwBj2ng0dXGzbBQYBZQAiszPaxBwo40DEVhTX1FE
apDbFEn2IPfKLShj7S8K++ehwTUeROdodbTf35TLJqWT/CyiwYfxr6mjNy1VrExc
4/Dl/ZUoWTNI9uh89tkef+y+6nLz9/C6fGFmApN4iS8QX7Zl+M3H14cL2EqFpXYr
FPqEesahSigHaSu4uuBFU5JvpPXeloFTBlnJ0m8vCaGfCBph2cLqksZep07pBEcC
bHF9pHOi0xZVdob7UTpA3AU5bzGyOJIjYgfVXBRC5pfgtmPe3F+d1pyeF//F6aGR
Jj4BfXzE52ffC5gys05wDtH4YfQGh+LuXeU+p1AKPsoHdF0ZZkxqdDjI09WtTuof
19V6fJP3es1tsVEMWgtR9Kpcd86Eluu94qfRmHro+cc8il7fesMYuj1TrXLWJo+p
WFcWIOZjZnd3niqg/JBzzxwZ0mropfjBT9uhzio4Aics8mE6nMTdZQ9FqPvYlOjZ
GIGlURyT72gyb0HSzn9mHq4dy+21SyqqQzh2dutH0QiVi452qfuFqnWI3QuYUnEd
WqUi51lJEdayAdQOpHr1Upr59LN3ZvYYmwfdw75/++4AYleIFSc=
=NyDi
-----END PGP SIGNATURE-----
--=-=-=--
