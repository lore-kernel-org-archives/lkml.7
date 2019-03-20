Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B57DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C72D21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553095695;
	bh=R94ODs+dzfvaQoLIiXlYh3ysVPDKkJPCLHnk39lv+Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0hsjuVCqSZ7Rz16CbLZsBBRXinpj/RpBBiJ8Kcj8xkKVYGcnMFg11L/dkg6ez5D2C
	 p2yovnNM2J7JBbcu2lWGdakOu/0lQC/uW3dhjYZCm8UqDKKiRguBuJVuNYqobl7TuZ
	 /qH9+0NVXVaMyFtpgHBF00IoDQAtLiBjKcfqygQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCTP2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfCTP2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:28:13 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E593B21874;
        Wed, 20 Mar 2019 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553095692;
        bh=R94ODs+dzfvaQoLIiXlYh3ysVPDKkJPCLHnk39lv+Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t78ntnp6dFNaeLUw9bk2L12LvLkCKD9TluN/jXqzd5J7z2EiL7Wncyv4feMuzvDfQ
         Pz5hEWB8eo2KgD3vWzbaoS58vRIUWgJyncWtEAAxztUh0hnF9sQEUFzkg0rRL3k5/h
         pb7vtyMDPLhbFGcDlmKfOJwq8ldKrp5gl9vWEltI=
Date:   Wed, 20 Mar 2019 17:28:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Make hns_roce_cmq_send static
Message-ID: <20190320152807.GV4823@mtr-leonro.mtl.com>
References: <20190320135047.23184-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="I4VOKWutKNZEOIPu"
Content-Disposition: inline
In-Reply-To: <20190320135047.23184-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2019 at 09:50:47PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1089:5:
>  warning: symbol 'hns_roce_cmq_send' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks for your patch, but such fix was already submitted.
https://patchwork.kernel.org/patch/10859135/

Thanks

--I4VOKWutKNZEOIPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcklwHAAoJEORje4g2clinKrUP/AtHDfAKaNyFoPE102Vb8ekJ
9lOrywDsrqMhrJFVdyV8NXFA1whVvffuMeYatx17gg8gOL13uXiviVrpTyAc6mqN
7V7YYST1BRBIO+GXM3duaRD49Mx7ZnSe0EPfr4Pbbg9raVmSg4npaDsT4SwK5yt0
rZWGCEgCR7O33hfcprun9YXuB2OnfAK93jeFu1t9I/g8IEThbusue5j1uo7E5x7l
5BkAN2zAE56p/XMOsJbbEQKCUzqXgOrz0MTKavL2CVvweyvyrAJOyAORDqRUO/1n
AHZvLcSsuv8wcmSggT28Cz/3DhlCXBuHTwQ/Xi09Y1bRorQONKA8ValtaM/JlNW6
PmuNx8fhGuQtG2nRaNKtXp3SZHYH0tdekMbKjdACzVnjqiWJ4fsMDOkEnMAGeHEW
Qu6eeQYespX2c0xiLhBJWbhDhRhB6lNbS6CrexK+XX3/FwPDUBg2OdA2kkp9I7Ho
6o85zwbjDVfxFIKenJU1uZMg/G/ZynbYGAKR8FU5WFgfWjz9fnJr2nZ39+igWvgy
LbIeRw9i8RqgUfqIKA5iPxZUqjaI1L+ES02J6Ne/thK7Fc1sCQdRdwhrJVSjgZDI
WWZeC5mZ7Zcx/zZ1Yk86lyS9f6naes6LZfq5CD/T5MZ0+1iutr7iTjN+/vhr9McS
m1y3GyAn52qhPnZKsad1
=Ntm2
-----END PGP SIGNATURE-----

--I4VOKWutKNZEOIPu--
