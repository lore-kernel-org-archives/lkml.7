Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02C6206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCLSwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:52:53 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCLSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:52:52 -0400
Received: from [192.168.1.110] ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFsdD-1hGm1n2TzL-00HQPk; Tue, 12 Mar 2019 19:52:48 +0100
To:     LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Openpgp: preference=signencrypt
Autocrypt: addr=info@metux.net; prefer-encrypt=mutual; keydata=
 xsBNBFrdoikBCADPd0lZAMqHA9mCQsKCelvoRicAR4dp2VkgTEOAqjiQwQktBXQ0IB/7KOVc
 kk7zOytB0GtgANMOyi1JAtIHQhpM/RxvJfAMHX9/woe4YNgO51tkoqYyQGx0/UIkhVdk4+lZ
 WoffmBA3+Rz2niu98utrqkyAFFoQ3AaBjBIpLVH3sqTlMp5sLb9X+4CyWv18FlyPL13vqIb6
 7QU7tJnAM7A81mrTj0/XNrrAHDA71+d7URAoAO613lv6qCQGPFZCy/Oi+hNAPAl3dY1oO6K1
 xVRvIQR+S0hDyENencONiFBW0Yj7x8pDqnMOpzVgPkfE7STykF84w3j69SX8Ky9CzD6XABEB
 AAHNMkVucmljbyBXZWlnZWx0IChtZXR1eCBJVCBjb25zdWx0KSA8aW5mb0BtZXR1eC5uZXQ+
 wsB4BBMBAgAiBQJa3aIpAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBQdN5H3K5O
 MqUyB/9ZHkkB9oMbE7kM5BwsC1LjzKU1nZ5eNjlbH9w7ax21tYnVU3kN2yKcQYJ4Xx/37fAV
 v/TcCA/Mh9+RKizuS5P/8Zgbl5UZqAeZwG2OEHn8guYUHOTEIS3VYl0hqi6gkiBxJOvnCmXl
 y7QLU/230xAKMiBaRKkrmWOLL++cYAmVF9n2arwjULiSDli5cOy5Fp8nJTLiBZDE78oYr0uz
 BS7ySXIri8N4pdhfezRFrOSP4FcRhSI0fhvkEEAWWF/8cdOrIq6pFXwcl7Fd/f9D109l9/RF
 gWk4vqFyqRC4gq2tcI3IgBK/6zEJDffPQRU8x6ofLaP0B+VQD1Hsont40gNHzsBNBFrdoikB
 CADf+V/VUBWY/QKKrdrCLW7hELI0Srw2Deh/Mgm7eenRM+R2W6S0ijAt9QASwveb8LhqwsQB
 S45cI3sl+pYFK1W7MFWnQ2mPW8LHhQUFEWECE0Rvt5TKobV5RUy7JE49zBv9FC+MLG6Q74TO
 HKUZfhPf2JB4uD4jOVQImiSdzmIn9Hegay7y7SxrsjxSaXq6y01+ClYh4RKQbowczDVYAyWx
 5jDLEkIXiHZmRnXjWcjrUCi48e+Gxnjz4h8g1MXW9JpBAs/J09Sp1hCrMZUb41f7aetBdbba
 1v8OJrJh/dpwfkQ2AaM3YX3j8FpiVCb0RfmUuO9XCeKagoCwnaVrDo9HABEBAAHCwF8EGAEC
 AAkFAlrdoikCGwwACgkQUHTeR9yuTjICaAf/RKhQo7Q5r5qI1ik69/umgPck5kV0OxuW+rZd
 9fsBEJruFYiQSPgU4EAqNrbYrcFYk5o82tk47ifRNIsi73LKBdmQT3ryjjEIRQKFmFcENAXr
 fcGzG3TjI3yXbUhoAq3onzPd5iJVuqm0FA2MLGYcVeM6z6okiJk4K4Oryp2Dz6mU+G7iy4S6
 dxhRnfPumGvusOiEI6vrlHPY6QWGzXlgGRlMi/x3fsiGLUmz/Q/yEELkzdsu1iJmLDMi2EmQ
 ikabQlXN9BkOgXU+4fMPFWTT60EQYkUO8lPiAeycws6oZ5mPwuJfZe48yv9D8QtFVcF8nMTp
 UWyGgOw+ALLA6Sr+Cg==
Subject: Standalone version of Kconfig
Message-ID: <088f45cb-204e-4fa4-1062-5574ef97cb8a@metux.net>
Date:   Tue, 12 Mar 2019 19:52:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7869LQXWJRHmcaGcu5y3lBNdHhPMaH2Z1TtX/79P3C1wKbH6j/w
 xBINaEU/MipDBALj1AdcKCoauG4oatQmlVwYBE6119ZB/lyCjWpfRKWCAIflEdOqutEIwTz
 nWjS9nPHvrzItodU+5T1GevIc35IH3XK7FUHwLs/6o61SJYUNNKi+dgvzyU3Y54YTEzjOju
 14XqK8LhRb5FZFrcUhsAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PttRPFFo8/o=:/JAVm6iclCAAX2I5GyJ3MJ
 b0IgH+CBKt13yH6eVeTKo/5LN0OKfT9w+LlkWkmI3XfibJ++FhpSIpl5cWW5lPJaJwWxqL2GE
 i/zrJeV3GXXJaq80qzzWdbOolupaZMDBghSsLIedyDuektw8rs5ToArLxEjVpSEmg5FYOyoQL
 d3h5pALIYo2+5QprIFtVRN58mBldrTIK2bSPbpRzQ3q+dyrLpnfQcSWUc1BZpUaHhUqQMUCwW
 eJS+lpwkUQ6eZUBX+CKDXTwUltm045r0bu6jsoRq74oRdjClGFTctGrtmXwYlnEVgtoztJG4c
 +gOcfMx1SfRe0NxgOqWvQ+T+mQ7l6bYf0DuKByLkOwALGkf/2GpBovobcnjpgx/QANsgOfJzS
 P80CmC6xBjCZtdcrLvovAxnlHaTbCE+UExU3i8Nf1CGucjqiRPGGpEzOX4jgZY4oL178zbBYb
 tGfrM7EZMsh8ErxrLDfzkSwZCC8o7jlauLxWf2jlIhx1aY0oqfJOBieXFjbvK8zdvSD3HXXPr
 LbpwCdJSz+DRWtkcksS33akZMB8eWOChyOnhFwyVxpIIZyGRwZFhyUgTPOGurn+pvxQagVB5C
 BTIQeQNEGEa1zxvKmnhNhz+kx4hyiK6PMBn2zkzAsY5JmK9EuWgErp8niVolb9CR9oR1Z2Otc
 jW/gPKcQi/8UAHKwctayTsRdX/PxfOTwHkMKTAjJpb7DI2YCNU53vudFUKVpykCeF/tJduAGO
 33YvZTISpZfa/jgnaj3bDCrQI9YsSELB9FQ2tHLLa0w6/SuQ8AbXGk0/d7I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


YFYI: I've started a standalone version of Kconfig, which can be used
other programs. There have been some attempts to do so, but none seem
to be still alive.

I intend to keep it alive for a long time and sync it w/ the kernel
regularily. The program is meant to be installed just as any other
program (not as part as some other, like it already is in the kernel
or busybox, etc) and I'm going to package it to some distros, too.

At the moment, I'm just supporting menuconfig (other versions follow).
Later, I'll also makefile includes for common stuff (eg. handle module
targets like we do in the kernel, etc).

I'll yet have to find a decent way for syncing w/ the kernel, while
retaining history. Maybe some filter-branch + rebase voodoo ;-)

Feel free to play around :)

https://github.com/metux/kconfig

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
