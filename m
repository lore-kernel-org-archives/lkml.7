Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C3A2084A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559656344;
	bh=Hyz6eND3R6Bcu0QiRWXZL/ZSyXeYxxrku/dLyneQLXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YD9wBlXjIJfPY2t+o/OCRLL7PcRs0nOI8HnW9ROa29m4AcamJF+Ym5heeNcpzCFXt
	 L51H3R2b9IRX6dHufKOIttAUIYmPobjj62qFtCcHuV/QJIUEMBR4HdbJ476YCr/+sF
	 ktvmcfKUC2DcGREyj7ZEUUx4IeQd4kfuCMxU4xbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfFDNwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:52:22 -0400
Received: from casper.infradead.org ([85.118.1.10]:58336 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xkJ5K7Ry3R0EMrSoSiHpEbxAEhSIrvb7VZ7JEOL85Ok=; b=gQgFCO+3VWDKckP/yDem/hmd8W
        f+84aEoA9L9dJ6ru/secQk5HrwhgCLqw4K/PuvIHQcJfmaQQJAXSlPL7fWh6EScsSx3gPRR7XRH5J
        Zu1NCXREruA0Roft/Rk/O1My0YmI+rVTNUHF2sY6Xe+uu/rMI0AyhCddvO4B5LMPkdLXFU3qsAR9K
        Q16GECVfENkx8u9BuUCDie6+rm8yXQZMxxxH6WxzyNC8XuyLA9xlaV7Th5mcKN/3S+fS16HSlLK3S
        eqq77bsIrSL9hQXSc2Z7y43O3bLNxjNvCGFXcQMryqdpEvMyXNgaYTTDJVWpTyIt2NU8IOK1cTUAI
        epFRUExw==;
Received: from [179.182.172.34] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY9rO-0006JT-P3; Tue, 04 Jun 2019 13:52:19 +0000
Date:   Tue, 4 Jun 2019 10:52:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: fix file references
Message-ID: <20190604105214.36147c02@coco.lan>
In-Reply-To: <20190530201455.12412-1-federico.vaga@vaga.pv.it>
References: <20190530201455.12412-1-federico.vaga@vaga.pv.it>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 30 May 2019 22:14:54 +0200
Federico Vaga <federico.vaga@vaga.pv.it> escreveu:

> Fix italian translation file references based on
> `scripts/documentation-file-ref-check` output.
>=20
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../it_IT/admin-guide/kernel-parameters.rst          | 12 ++++++++++++
>  .../translations/it_IT/process/adding-syscalls.rst   |  2 +-
>  .../translations/it_IT/process/coding-style.rst      |  2 +-
>  Documentation/translations/it_IT/process/howto.rst   |  2 +-
>  .../translations/it_IT/process/magic-number.rst      |  2 +-
>  .../it_IT/process/stable-kernel-rules.rst            |  4 ++--
>  6 files changed, 18 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/translations/it_IT/admin-guide/kernel-p=
arameters.rst
>=20
> diff --git a/Documentation/translations/it_IT/admin-guide/kernel-paramete=
rs.rst b/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst
> new file mode 100644
> index 000000000000..0e36d82a92be
> --- /dev/null
> +++ b/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst
> @@ -0,0 +1,12 @@
> +.. include:: ../disclaimer-ita.rst
> +
> +:Original: :ref:`Documentation/admin-guide/kernel-parameters.rst <kernel=
parameters>`
> +
> +.. _it_kernelparameters:
> +
> +I parametri da linea di comando del kernel
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. warning::
> +
> +    TODO ancora da tradurre
> diff --git a/Documentation/translations/it_IT/process/adding-syscalls.rst=
 b/Documentation/translations/it_IT/process/adding-syscalls.rst
> index e0a64b0688a7..c3a3439595a6 100644
> --- a/Documentation/translations/it_IT/process/adding-syscalls.rst
> +++ b/Documentation/translations/it_IT/process/adding-syscalls.rst
> @@ -39,7 +39,7 @@ vostra interfaccia.
>         un qualche modo opaca.
> =20
>   - Se dovete esporre solo delle informazioni sul sistema, un nuovo nodo =
in
> -   sysfs (vedere ``Documentation/translations/it_IT/filesystems/sysfs.tx=
t``) o
> +   sysfs (vedere ``Documentation/filesystems/sysfs.txt``) o
>     in procfs potrebbe essere sufficiente.  Tuttavia, l'accesso a questi
>     meccanismi richiede che il filesystem sia montato, il che potrebbe non
>     essere sempre vero (per esempio, in ambienti come namespace/sandbox/c=
hroot).
> diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/=
Documentation/translations/it_IT/process/coding-style.rst
> index 5ef534c95e69..a6559d25a23d 100644
> --- a/Documentation/translations/it_IT/process/coding-style.rst
> +++ b/Documentation/translations/it_IT/process/coding-style.rst
> @@ -696,7 +696,7 @@ nella stringa di titolo::
>  	...
> =20
>  Per la documentazione completa sui file di configurazione, consultate
> -il documento Documentation/translations/it_IT/kbuild/kconfig-language.txt
> +il documento Documentation/kbuild/kconfig-language.txt
> =20
> =20
>  11) Strutture dati
> diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documen=
tation/translations/it_IT/process/howto.rst
> index 9903ac7c566b..44e6077730e8 100644
> --- a/Documentation/translations/it_IT/process/howto.rst
> +++ b/Documentation/translations/it_IT/process/howto.rst
> @@ -131,7 +131,7 @@ Di seguito una lista di file che sono presenti nei so=
rgente del kernel e che
>  	"Linux kernel patch submission format"
>  		http://linux.yyz.us/patch-format.html
> =20
> -  :ref:`Documentation/process/translations/it_IT/stable-api-nonsense.rst=
 <it_stable_api_nonsense>`
> +  :ref:`Documentation/translations/it_IT/process/stable-api-nonsense.rst=
 <it_stable_api_nonsense>`
> =20
>      Questo file descrive la motivazioni sottostanti la conscia decisione=
 di
>      non avere un API stabile all'interno del kernel, incluso cose come:
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/=
Documentation/translations/it_IT/process/magic-number.rst
> index 5281d53e57ee..ed1121d0ba84 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-ita.rst
> =20
> -:Original: :ref:`Documentation/process/magic-numbers.rst <magicnumbers>`
> +:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
>  :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
> =20
>  .. _it_magicnumbers:
> diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules=
.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
> index 48e88e5ad2c5..4f206cee31a7 100644
> --- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
> +++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
> @@ -33,7 +33,7 @@ Regole sul tipo di patch che vengono o non vengono acce=
ttate nei sorgenti
>   - Non deve includere alcuna correzione "banale" (correzioni grammatical=
i,
>     pulizia dagli spazi bianchi, eccetera).
>   - Deve rispettare le regole scritte in
> -   :ref:`Documentation/translation/it_IT/process/submitting-patches.rst =
<it_submittingpatches>`
> +   :ref:`Documentation/translations/it_IT/process/submitting-patches.rst=
 <it_submittingpatches>`
>   - Questa patch o una equivalente deve esistere gi=C3=A0 nei sorgenti pr=
incipali di
>     Linux
> =20
> @@ -43,7 +43,7 @@ Procedura per sottomettere patch per i sorgenti -stable
> =20
>   - Se la patch contiene modifiche a dei file nelle cartelle net/ o drive=
rs/net,
>     allora seguite le linee guida descritte in
> -   :ref:`Documentation/translation/it_IT/networking/netdev-FAQ.rst <it_n=
etdev-FAQ>`;
> +   :ref:`Documentation/translations/it_IT/networking/netdev-FAQ.rst <it_=
netdev-FAQ>`;
>     ma solo dopo aver verificato al seguente indirizzo che la patch non s=
ia
>     gi=C3=A0 in coda:
>     https://patchwork.ozlabs.org/bundle/davem/stable/?series=3D&submitter=
=3D&state=3D*&q=3D&archive=3D



Thanks,
Mauro
