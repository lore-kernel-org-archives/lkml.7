Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED2C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2D22D6D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfIBFj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 01:39:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:14981 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfIBFj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:39:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Sep 2019 22:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="gz'50?scan'50,208,50";a="186917162"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2019 22:39:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i4f4E-000HSP-9f; Mon, 02 Sep 2019 13:39:54 +0800
Date:   Mon, 2 Sep 2019 13:39:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     kbuild-all@01.org, Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/4] regulator: provide regulator_bulk_set_supply_names()
Message-ID: <201909021322.R7xZaugE%lkp@intel.com>
References: <20190830071740.4267-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ajp7xublaoyz7646"
Content-Disposition: inline
In-Reply-To: <20190830071740.4267-2-brgl@bgdev.pl>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ajp7xublaoyz7646
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc6 next-20190830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/regulator-add-and-use-a-helper-for-setting-supply-names/20190901-140224
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: drivers/of/platform.o: in function `regulator_bulk_set_supply_names':
>> platform.c:(.text+0xe8): multiple definition of `regulator_bulk_set_supply_names'; drivers/usb/phy/of.o:of.c:(.text+0x0): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ajp7xublaoyz7646
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNiobF0AAy5jb25maWcAnVxtc9s4kv4+v4KVqbpKaicZvyTZzF35A0SCElYESROkZOcL
SyPRjiq25NXLTHK//roBUgTJhpK9rdnEQTdAoNHofrrR8K+//Oqx42H7vDisl4unp+/eY7Wp
dotDtfIe1k/V/3hB4sVJ7vFA5O+AOVpvjt9+36z211feh3fX7y7e7pYfvWm121RPnr/dPKwf
j9B9vd388usv8N+v0Pj8AiPt/tvTvZ6qt084xtvH5dJ7Pfb9N96nd5fvLoDXT+JQjEvfL4Uq
gXLzvWmCf5QznimRxDefLi4vLk68EYvHJ9KFNcSEqZIpWY6TPGkHqglzlsWlZPcjXhaxiEUu
WCQ+86BlzCcZZ0Ep4jCBP8qcqSkQ9YLGWkJP3r46HF/aaY+yZMrjMolLJdN2IBy95PGsZNm4
jIQU+c31FYqlnlAiUxHxMucq99Z7b7M94MAtwwSmwbMBvaZGic+iZvmvXrXdbELJijwhOo8K
EQWlYlGOXevGgIesiPJykqg8ZpLfvHq92W6qN9bY6l7NROqT0/WzRKlScplk9yXLc+ZPSL5C
8UiMbJKWrchuvf3xz/33/aF6bmU75jHPBOhFdluqSTK3NMOi+BNhCx5agkQyEbdtExYHIGzT
jBxA+tWrNitv+9D7dv8DuZC8nMHSQa7R8Ps+CHzKZzzOVaMn+fq52u2p5Uw+lyn0SgLh6wnU
zXGCFAEzJEWmybSOiPGkzLjSk8xUl6de3WA2zWTSjHOZ5jB8zO3ZNO2zJCrinGX35KdrrsFG
+mnxe77Yf/UO8F1vAXPYHxaHvbdYLrfHzWG9eWzFkQt/WkKHkvl+At8S8bgzESXIFf3EJ/RU
Mr/w1HAT4DP3JdDsT8E/S34He0OdNWWY7e6q6V9PqfupdlwxNT8MxKSWX6rVEayj91AtDsdd
tdfN9XAE1Tpp4ywpUkWfwgn3p2ki4hzVIk8yWqMU8AXaOuixSJ6MR4ze+lE0BWsx0xYuCwiB
gbFNUlBJsKxlmGSo8/CXZLHfUbQ+m4IfiNHMvtgdJdgpAYYkoxc35rkEs13WZ5ZmulehOssR
GptBK3+ixB156E6nA7ZgSkuvGNPtTIEYCtdsipzfkRSeJq41inHMojAgiXryDpo2Zw6amoCN
JylMJGS7SMoCxEGvmgUzAeuuN4IWJnxwxLJMOPZ7ih3vJd13lIZndxm1SPu9kFJk+DAPAhse
TNiMa30uTza/3XT/8uL94KTXECmtdg/b3fNis6w8/le1AXvF4LD7aLHAPhvbWY/TDk/av58c
sR1wJs1wpbayLp1FRMJygDO03qqIjQgRqagY2UJQUTJy9oetzMa8gRputhCcSyQUGDE4gwmt
bl3GCcsC8MgunS3CENx/yuDjoAkAkcA0Og5uEopooK215LsIsBFBHKjrKwIZALQcZSzH9YIp
JRhUIYetkzkHr55bDidjPkfMEkZsDDarSNMks+gKsNbUMA1oIZgpzrLoHv6N56ilpOOcjUAm
EWhGpG6uarekHZiXf3+pGhif7rbLar/f7ryw9VSNyoDvHuE5iQPB4o5tB0ok8hy+YIi0VUsL
yn1AXx/wI+6VYKqHCpAaX36gVVjTrs/QLpy04MyYQbefRZldtyIFXQUoppUMXVn5fto5GX3y
pyl9UHBYYdYfCIWb5J7Xf8Q2z0TOIb5JijGNzeejmNE4c96oFoRNsCnjWKI5AdjGlcOY6C9G
V67h0i4y0Zomq+ft7ru37AWTlhlTKehUeT0mNqMlIqiw5d5QrmgP1JAvqVH1biVhqHh+c/Ft
dGH+1xoEcsonu5Ch9NXNZdMgpYUjtdXQoRggyjLIRyaMaxCgdRBtNxLaaLGNKiAyJmYPhKsP
F7YsoOX6gj4DZhR6mBsYZuB/whaaopnY/g1wFbzR4rF6BmfkbV9QGJaxYJk/ATVSKRgERFBK
gM52XIeh0XZZkgbZ+dVOwL7YLb+sD9USp/t2Vb1AZ3KG2rnraWpzOkmSqXW6sf36agSqAgpR
5j1MkHGwzXDEjTmuj0bJUtHj8yNrzDorobuA58m5D36pCcgapUmCIgLDAUil5FGocXlvTH4H
kzKJC2vsCIYBVOlP5+AbVUv4+B7XgPjPYja+3yyvJlmRQKiBwwCdGiH7yeztn4t9tfK+GsV4
2W0f1k8m0mtd5xm202mLijGcBcxA+P7Nq8d//MM6ET+5maccB8JpJTFmv7SgpBGmI6yBSJ5Q
fxEDHoCxUphaESNTnUDo0nXayNDP0ci+2jK7OtvEurcWLP9WLY+HxZ9Plc7YeRoMHjqWYSTi
UOaoNvSKDVn5mUhpNFZzSKEcWR+IMINCpuThdE3QNvbyjMEAvJN3MAs2wOkIOEKZUjIr6WNs
eJprIWmr+76HbP1cJDQKmSpJbHuTD5PwHRBADKFKkN28v/jj48mCcwiiAaxrHzuVHZAScYh2
0QfSYpO0n/2cJgkdp3weFbRh/Kx1PKG3ByaHcwP70g8lGtBZpOWIx/5Esj7s73o4Yp+sBBUf
5oGC6q81BCbBbv1XP7zxfdZNG7TGer2se3jJSRvaWM0EMRMepY5QMOCzXKYhvVaQQhwwtIqu
hJYePhSZBIvJTZZ0MM1wvXv+e7GrvKftYlXt7PmF8zJKMGlLCrLf0QKGsH9znVGhj9NpcaMC
/szEzLl6zcBnmcPCGQbMKNfDgGGSyYxKupxiFISPfCbAm9n5LsdmaWmMjntvpXe/k9Oymy0F
jB0AUuZUQB7k1uVAEtpHLgkxpZ878uVAReuRQ7xoD2CCI5qE5x18eKetY7wTdMaKZzMwA8ZO
2ZMBuWauDFrKMgTTA+WKZ5J76vjyst0dbNl12o35XO+XHSk3AiqkvMdp0omdGFCBKkC5cdq4
qfRJyRgdc99haHxXqiDkDoMzS1ksHL7iilwz54B8pLe3Vt3MVlPKP679u4+0g+l2Ncn36tti
74nN/rA7PuukyP4LnLqVd9gtNnvk8wBzVN4KBLh+wR9tQf8/euvu7OkA4MQL0zEDX1cf9NX2
7w0edu95i8lc7/Wu+vdxDYjZE1f+mya+FpsDgCEJQvsvb1c96Ru4Vhg9FjxE5sw1NOWLkGie
JWm3tY13EjD5hRrsQ/uRyXZ/6A3XEv3FbkVNwcm/fTklENQBVme7ktd+ouQby0mc5m7Nu7ml
OSMnS2f8SUL7MfvA1NNWom6xBN4cASAiWrSNHtWhXu3L8TAcqs2AxmkxVPwJSFLrifg98bBL
5yArvCeifTaTvH+STnOkBm0lSEzTfBOUfLEEFaZMSp7TRgzcgisVDKSpi4YLY5F2dz01bOWV
SlFf2dGebjI/lxnMffh/P2BsLVh0P/huc7E0EIPZ3iuf3NUrnxzFZre4r2mrCGGFo13ShEn/
VqwxvenwTKd56i2ftsuvfYvCNxqWp5N7vIzFKzTAcPMkm5bQpANAQEsyxTzoYQvjVd7hS+Ut
Vqs1OnqIwvSo+3f2AR1+zJqciP08o6HtOBVJ70q4zUhdOu5f5gBe2Mxx+aKp6JrpoMbQMaEV
0Zo9mUtHqJBPeAZ4m54ry/1JkFBpJKVGdMZDUSn1EYQHJPuoFzcYJHB8Oqwfjpsl7kxzuldD
2C3DoMR4KgK0w+98x9lpuSaRH9AqizwScS4dxCB5Ij6+v7osU+nAApPcBxCkhE/nanGIKZdp
RMc8egL5x+s//ukkK/nhgtYdNrr7cHGhoba7973yHRqA5FyUTF5ff7grc+WzM1LKb+XdJxq7
nN22dpSMj4vIeVsheSBYk5odRlS7xcuX9XJPGa8gc1juTJZBWvpdfGcwDnQhcL3dbPj81HvN
jqv1Fpz/6fbgzaBIqB3hpzqY6Gu3eK68P48PD2Ckg6GvCkeksMluJlhZLL8+rR+/HABVgMKf
ceJAxaojpep4iM6XMH8a4fXNGdYmHvrBl0+hVn8XLfORFDEVJRVgbpKJL7o3MG3ggvTBVRE2
6hwnZiQnfmAbnkINK3awTQPiVRe9YXv65fsey8q8aPEdvenQGsWAQvGLdz4XM1I+Z8bpTAzw
UDB2WPr8PnUEKtgxS0A2ai5yZ6nSqCyiVDhxSjGnvZaUDpPApcKaF5IY83kZ8YD+kkknixHE
X1001pgJsKfgQztZ29w3SkifczTggwjQZG4kGxWhlY5r9e0+9stQ9G+a6g3r9bMmX9wFQqWu
YLhw4NyZyJo8Bb0GZBAJSDUuBouQ6+Vuu98+HLzJ95dq93bmPR4rCGv2w+D6R6zW+nM27l0N
n/J9UwS0UZJMi3SY8cfkEsT83YQ7YIz6NqApl3wGT+BrBKUN1t/b3Vdb/DjQRAW0+rQD4qUv
ZiRkX64NyqU/ZMMfzHX3s+FmJrqT2h53HZDRTlBlvv5y5+Iz91ORX4LT1UUn9KSoga2Tw0Q0
SugCGAErL5xOMKuet4cKY1DKDGH+K8csAg3lic5m0Jfn/SM5XipVo5j0iJ2ePVM+F8StqIK5
va6vAxPYti/rlzfe/qVarh9OCbiT8WXPT9tHaFZbvzO9xtMSZNMPBoR42tVtSDXOc7ddrJbb
Z1c/km4SXXfp7+GuqvZg3CvvdrsTt65BfsSqedfv5J1rgAFNE2+PiyeYmnPuJN3eL6wMHWzW
HV5ofRuM2U2fzfyC1A2q8yn38FNaYMU4ErFHmHFHIvAudwJcXcJLnzSHpU7nciAJTEEuYZbD
1ApQ6oJdKwMORssRTffHsaaT4k2ryznr+A/MYpyDn+8lEkxwPLnvlIe2AWmd+0YGEuT5spwm
MUOAcOXkwkAaggMe+xwQ9U+wnBknVFEpIJSQt30o1mGTYPgj+BMgy9nh0jtWXn2KJeYSHHlc
mwuXSe5NV4K9ANtn9KKlTy8gY0Mowjar3Xa9sjeHxUGWiICcT8NuwRxG+4y4n7oyGbk55nmX
680jFQConA6ZRJyD1PMJOSViSCtawXQxNWToyPEo4fCBKhLSmU3Dkj/4OeY+jZLrqkAa1HWv
8eorMDDEZtM75m3GIhFgvVuIZU6Zqz6X36GjBh594V4mjlJmxJn4mmHqKh2FEeDkZPep82I3
iJNchA5bZmils4w4ZGd63xZJTm8dFlWH6n3puIQ0ZBc1xCIPB62+T+qRjfwXyy+9OFgRl88N
1DLcxgbuq+Nqq6/niQ1FXOSajqaBHY+CjNPS1yXWDoXDvwgxNHZlOCvLfghlghAYP+eOst/Y
UUpcxMJPAlouHbU20KtaHnfrw3cqFprye8flGfeLDKI0CLG40m4oB2fiKHatebtysIOHpq5V
66mfpPdt/WqnrqvPRn8uZxB+ah4JUhhepDfnpi59aJfCrGvXSMmbV98Xz4vf8HLrZb35bb94
qKD7evXbenOoHlFkrzpVa18Wu1W1QSPYStKuAllv1of14mn9v01u6HRIRV4XVPVfqWgSPnFC
cZxm7DAEDTOWCzt5uwUP/Sn1it+IFZ2gWl9rLMVHa5UMzm+0/nO3gG/utsfDetM9yYhx6Jhz
JHIsWQA7OywiBp2LfVCWEC9Qcb9plojHDdU6nFnQRQUnB42GlkUdZgj3fF/kDseS+ZcfXZQS
IsJA0IVJSBZ5UVI3+UDT1dY28/UV6GoUOu7+a4ZI+Hx0/4noaijvXVNBFpbNwbOd4YDdcFE/
Okd2EujEdiRG+mOuF3j+Jweywqsyh4za4OQznAxq3xuFsQ3PyewoDL/tGi3TpEuFOwVa2B5I
q3JRV09BC7Jpy2SpMTbDZCKWcdDHCQcXY2UqT1lKnY9CXnw9ZNJZP+Ly04JgQSqmaIiPISnj
naXo2UGo7ucnip1Xw6JPU2pzTph5IgVoRsekZbel8zFPIGTvkqxVijDoFDyjw4nHjt2ujdTA
5PQnCMOWTE2iQFwPbUdNzJzE6BxRFu5RfZkGgnhMgbTiROz6luVXU2uqW1924IO+6ivN1XO1
fxyWFcJfKtHYcqwfPzQO4eafTo7bQvD85v2pJJcrhYXhgxHetwJ2zqNJ9uHb6Lf6BSPAseXX
vWZd1m+mKcRhqrfwYTINq2P9nkMWKjfPAAldCTMmuX4EfXN5cfW+qzKpfjbtfEmFNaz6C0zR
cVARgyvBuzM5ShzwyyzBgQrNg2ewHjFYg+4paCBw81pQV8b23oWYsQGyoJdClCiZK7HfZzLP
wpPYcR1czzrJIEyfczZtaj5d2dWf21kL0bIx+uN71a3a6nx9yrOYR8P19itzbVQVVH8eHx+b
OuwTnhhjwXjOY+UMm/TIyHimslQ/jJjHjuBJk9NEqCR2hW/mK8noX7AZTvhbLx48TASCHy6/
oZz5goGPBR7YM1wzVyGLFrJ51Y4okoIXpoh/yhSLG3vVGjDTrCehC9G7KLPdov6TABb7yax+
+5X6hKJPekV+ddUtjOdF2+XX44vRu8li89i9xElCXSVdpDCSeXHgWDoSy0kBrgR/CwLJNL8l
yx6s9AE9H1tTICRDbJ70EgEUHVMMBW9/3YMh4q1CUuQ3F9Yi9QNns/X43GRgEHvSxCGmnKc9
ZTXoHG8mThvlvd5DyKOrX37zno+H6lsFP1SH5bt3794MzTV1k9LXLnzae7ZiN5srV6BrGAya
ACALSzjDVmdTNEBp0AE9rM7MgGbkWCvqhIzzuZn8D6DGfyC/Tqxav2qkP40WG8wTeB0FQBI2
+0xBWG0rjK05Jx/hWGhtEX9AV+cMnU4mCddVpuHxM1hJjL+TZJjjwd8wQBp0/NUF+sWwc5uQ
44d7qZmc4ta/H+FWDWFt5zcgWNastzKwE8Z/ZoTnbAKCWkIlzzJA6iL+F3e/2TAhPMlj+4+w
iI2r10vrRC42dZyxdELzBPcxw7MVamp/AGOfpXkeBREBxM7dh7saiJ9KLdrpnxE1/iIMaXYK
e/evt1vYwKVzN7VrjcuA5QwD+qxwJ0kVk6nrSVQxUoySrW4vTw9B7SLZHir/P3IE5MJoSAAA

--ajp7xublaoyz7646--
